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

  #store to database
  @project = Project.create(project_params.merge(user_id: params[:user_id]))
  tags = params[:tags]
  tagsArray = tags.split(",")
  intTagsArray = tagsArray.each do |t|
    tag = Tag.find(t)
    @project.tags << tag
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

  #charge the card
  nonce = project_params[:nonce]
  userid = params[:user_id]

    result = Braintree::Transaction.sale(
      :amount => "4.44",
      :payment_method_nonce => nonce,
      :customer => {
        :id => userid
      },
      :options => {
        :store_in_vault => true
      });

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
  @names = @project.names
end

def vote
  nid = params[:nameid]
  uid = params[:voterid]
  name = Name.find(nid)
  user = User.find(uid)
  project = name.project
  name.liked_by user
  names = project.names
  votes = []
  names.each do |v|
    vote = {:name => v.name, :totalvotes => v.votes_for.size}
    votes << vote
  end

  render json: votes
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

private
  def project_params
    params.require(:project).permit(:name, :description, :photo_url, :emails, :nonce)
  end

end