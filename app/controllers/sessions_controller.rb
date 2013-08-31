class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authentication(params[:username],params[:password])
    if user
      session[:user_id] = user.id
      redirect_to new_accept_path, notice: "Logged in.."
    else
      redirect_to root_url, notice: "Invalid username or password.."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out..."
  end
end
