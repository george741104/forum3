class Admin::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_user , only:[:update, :destroy]

  def index
    @users = User.all
    @users = @users.page(params[:page]).per(10)
  end

  def update
    @user.update (user_role_params)

    redirect_to admin_users_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end




  def check_admin
    unless current_user.admin?
      raise ActiveRecord::RecordNotFound
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_role_params
    params.require(:user).permit(:role)

  end
end
