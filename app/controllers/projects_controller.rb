class ProjectsController < ApplicationController

before_action :confirm_logged_in, except: [:show]
before_action :current_user
before_action :confirgurebraintree, only: [:new, :create]

def new
  @client_token = Braintree::ClientToken.generate
  @project = Project.new
  @tags = Tag.all
end

def create
  #store to database & push more emails into email array
  @project = Project.create(project_params.merge(user_id: params[:user_id]))

  #load email arroy with user specified people
  emailstring = @project.emails
  emailarray = emailstring.split(",")

  # add tags and emails associated with tags
  tags = params[:tags]
  tagsArray = tags.split(",")
  intTagsArray = tagsArray.each do |t|
    tag = Tag.find(t)
    @project.tags << tag

    # add email addresses to tag array if nonce is valid
    if project_params[:nonce] != nil
      if tag.users.exists?
        emailarray << tag.users.first.email
        puts "ping"
      end
    end
  end

  #charge the card
  nonce = project_params[:nonce]
  result = Braintree::Transaction.sale(
      :amount => "4.44",
      :payment_method_nonce => nonce,
    );

  #send the emails
  if emailarray.length > 0
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

  #moveon.org
  if @project.save
    flash[:success] = "Your new project has been saved!"
    redirect_to user_project_path(@current_user.id, @project.id)
  else
    flash.now[:alert] = "Please finish filling out the project form"
    @data = project_params
    @tags = Tag.all
    render :new
  end
end


def show
  @project = Project.find(params[:id])
  @tags = @project.tags
  @user = User.find(params[:user_id])
  @comments = Comment.where project_id: params[:id]
  @names = @project.names
end

def vote
  @name = Name.find(params[:nameid])
  user = User.find(params[:voterid])
  @name.liked_by user
  votes = {:vote => @name.votes_for.size}
  render json: votes
end

def name
  newname = Name.create(name: params[:name], created_by: params[:user], project_id: params[:id])
  render json: newname
end

def edit
  @project = Project.find(params[:id])
  if @project.user = @current_user
    @tags = Tag.all
    @tagged = []
    @project.tags.each do |x|
      @tagged << x.id
    end
  else
    redirect_to "/"
  end
  # pass all tags
  # and tags selected
end

def update
  # udpate newly selected tags
  @project = Project.find(params[:id])
  @project.update_attributes(project_params)
  @project.tags = []
  tags = params[:tags]
  tagsArray = tags.split(",")

  tagsArray.each do |t|
    tag = Tag.find(t)
    @project.tags << tag
  end

  if @project.save
    flash[:success] = "Your project has been saved"
    redirect_to user_project_path(@current_user.id, @project.id)
  else
    render :show
  end
end

def pay
  render :json => "done"
end


private

  def project_params
    params.require(:project).permit(:name, :description, :photo_url, :emails, :nonce)
  end

end