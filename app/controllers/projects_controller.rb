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

  client = SendGrid::Client.new do |c|
    c.api_user = 'namelessapp'
    c.api_key = 'hellohello3'
  end

  headers['X-SMTPAPI'] = { :to => emailarray }.to_json

  mail = SendGrid::Mail.new do |m|
    m.to = 'ignore@ignore.com'
    m.from = 'namelessapp@wlessin.com'
    m.subject = 'Hello world! x2'
    m.text = 'I heard you like pineapple.'
  end

  puts client.send(mail)



end

def show
  @project = Project.find(params[:id])
  @tags = @project.tags
end

def edit
  @project = Project.find(params[:id])
  @tags = Tag.all
  @tagged = []
  @project.tags.each do |x|
    @tagged << x.id
  end
  # pass all tags
  # and tags selected
end

def update
  # udpate newly selected tags
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