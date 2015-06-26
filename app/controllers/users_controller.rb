class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update, :destroy]

  def index

    if UserProfile.exists?(current_user.id)
      @user=UserProfile.find(current_user.id)
    else
      @user=UserProfile.create(:user_id=>current_user.id)
    end
    #@user = UserProfile.find(params[:id])
    @post = Post.where(current_user.id)
    @comment = Comment.where(current_user.id)
    @posts = @post.page(params[:page]).per(10)
    @comments = @comment.page(params[:page]).per(10)
  end

  def new
    @user=UserProfile.new

  end

  def create
    @user = User.find(current_user.id)
    @profile.user_id = current_user.id
    if @profile.save
      flash[:notice] = "Profile info created"
    else
      render :action => :new
    end

  end

  def edit

  end

  def update
    @user.update(user_params)

    redirect_to users_path(current_user.id)
  end





  private
  def set_user
    @user = UserProfile.find(params[:id])

  end
  def user_params
    params.require(:user_profile).permit(:first_name, :last_name, :birthday, :phone, :nick_name)
  end
end
