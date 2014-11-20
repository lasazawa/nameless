class ProjectsController < ApplicationController

before_action :confirm_logged_in, except: [:show]
before_action :current_user


def new
  @project = Project.new
  @tags = Tag.all
end

def create

  #store to database
  @project = Project.create(project_params.merge(user_id: params[:user_id]))
  tags = params[:tags]
  tagsArray = tags.split(",")
  intTagsArray = tagsArray.each do |t|
    tag = Tag.find(t)
    @project.tags << tag
  end

  if @project.save
    flash[:success] = "Your new project has been saved!"
    redirect_to user_project_path(@current_user.id, @project.id)
  else
    flash.now[:alert] = "Please finish filling out the project form"
    @data = project_params
    @tags = Tag.all
    render :new
  end

  #send invite emails
  emailstring = @project.emails
  emailarray = emailstring.split(",")
  emailarray.each do | email |

    client = SendGrid::Client.new(api_user: 'namelessapp', api_key: 'hellohello3')
    mail = SendGrid::Mail.new do |m|
      m.to = email
      m.from = @project.user.username + '@namelessapp.com'
      m.subject = 'Help me name my new project'
      m.text = 'I have a new project and would love your help naming it.  the idea is' + @project.description
    end
    puts client.send(mail)
  end
end


def show
  @project = Project.find(params[:id])
  @tags = Tag.all
end

def edit
  @project = Project.find(params[:id])
end

def update
  @project = Project.find(params[:id])
  @project.update_attributes(project_params)
  if @project.save
    flash[:success] = "Your project has been saved"
    redirect_to user_project_path(@current_user.id, @project.id)
  else
    render :show
  end
end

private
  def project_params
    params.require(:project).permit(:name, :description, :photo_url, :emails)
  end

end