class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in, only: [:show, :edit, :index, :update, :destroy]
  before_action :is_admin, only: [:index]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    puts user_params.to_yaml
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to new_accept_path
    else
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def is_admin
    unless current_user.is_admin?
      redirect_to notes_path, notice: "Access to User Management is only permitted for admins"
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :password, :password_confirm, :is_admin)
    end
end
