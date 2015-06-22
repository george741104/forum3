class PostsController < ApplicationController
  before_action :set_post, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  def index
    @posts = Post.all
    @posts = @posts.page(params[:page]).per(10)
  end

  def show
    #@post = Post.find(params[:id])
    @comments = Comment.all
    @comment = @post.comments.new
    @comments = @comments.page(params[:page]).per(10)
  end

  def new
    @post=Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save

    redirect_to posts_path
  end

  def edit

  end

  def update
    @post.update(post_params)
    redirect_to posts_path
  end

  def destroy
    @post.destroy

    flash[:alert] = "Post was deleted"
    redirect_to :back
  end


  private
  def set_post
    @post = Post.find(params[:id])
  end
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
