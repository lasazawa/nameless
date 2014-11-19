class AccessController < ApplicationController

  before_action :confirm_logged_in, except: [:attempt_login, :login, :logout]
  before_action :prevent_login_signup, only: [:login]
  before_action :current_user

  def login
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = User.where(username: params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end

    if !found_user
      flash.now[:alert] = "Invalid username"
      render :login
    elsif !authorized_user
      flash.now[:alert] = "Invalid password"
      render :login
    else
      session[:user_id] = authorized_user.id
      flash[:success] = "You are now logged in."
      redirect_to user_path(session[:user_id])
    end
  end

  def logout
    session[:user_id] = nil
    session[:admin] = nil
    flash[:notice] = "Logged out"
    redirect_to ('/')
  end


end
