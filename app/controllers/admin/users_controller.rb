class Admin::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin

  def index
    @users = User.all
    @users = @users.page(params[:page]).per(10)
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
end
