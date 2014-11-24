class UsersController < ApplicationController

  before_action :confirm_logged_in, except: [:new, :create]
  before_action :prevent_login_signup, only: [:new, :create]
  before_action :current_user

 def new
    @user = User.new
 end

 def create
    @user = User.create(user_params)
    @user.picurl = "https://cdn2.iconfinder.com/data/icons/free-basic-icon-set-2/300/2-512.png"
    if(@user.save)
      session[:user_id] = @user.id
      flash[:success] = "You are now logged in!"
      redirect_to edit_user_path(@user.id)
    else
      render :new
    end
 end

def show
  @projects = Project.all
  @user = User.find(params[:id])
end

def edit
  @tags = Tag.all
  @user = User.find(params[:id])
  @tagged = []
  @user.tags.each do |t|
    @tagged << t.id
  end
end

def tag
  newtag = Tag.create(name: params[:tagname], created_by: params[:user])
  render json: newtag
end

 def update
    @user = User.find(params[:id])
    @user.update_columns(user_params_update)
    redirect_to user_path(@user.id)
    @user.tags = []
    tags = params[:tags]
    tags_array = tags.split(",")
    tags_array.each do |t|
      tag = Tag.find(t)
      @user.tags << tag

    email = user_params_update[:email]
    firstname = user_params_update[:firstname]

    client = SendGrid::Client.new(api_user: 'namelessapp', api_key: 'hellohello3')
    mail = SendGrid::Mail.new do |m|
      m.to = email
      m.from = 'admin@namelessapp.com'
      m.subject = 'welcome to nameless ' + firstname
      m.text = 'welcome to nameless'
    end
    puts client.send(mail)

    end
 end

#########

  private
   def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
  def user_params_update
    params.require(:user).permit(:firstname, :lastname, :age, :city, :picurl, :email)
  end

end

