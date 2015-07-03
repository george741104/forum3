class UsersController < ApplicationController

  def show
    @user = User.find( params[:id] )
    @profile = @user.user_profile

    unless @profile
      @profile = UserProfile.create( :user => @user )
    end


    @posts = @user.posts.page(params[:page]).per(10)
    @comments = @user.comments.page(params[:page]).per(10)
  end

  def edit
    @user = current_user
    @profile = current_user.user_profile
  end

  def update
    @profile = current_user.user_profile

    @profile.update(user_params)

    redirect_to user_path(current_user)
  end

  private

  def set_user
    @user = UserProfile.find(params[:id])
  end

  def user_params
    params.require(:user_profile).permit(:first_name, :last_name, :birthday, :phone, :nick_name)
  end
end
