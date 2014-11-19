class UsersController < ApplicationController

  before_action :confirm_logged_in, except: [:new, :create]
  before_action :prevent_login_signup, only: [:new, :create]
  before_action :current_user

 def new
    @user = User.new
 end

 def create
    @user = User.create(user_params)
    if(@user.save)
      session[:user_id] = @user.id
      flash[:success] = "You are now logged in!"
      redirect_to user_path(@user.id)
    else
      render :new
    end
 end

def show
  @user = User.find(params[:id])
end


#########

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

end

