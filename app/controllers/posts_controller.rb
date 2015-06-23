class PostsController < ApplicationController
  before_action :set_post, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  def index
    sort_by = (params[:order] == 'name') ? 'name' : 'created_at'
    @posts = Post.order(sort_by).page(params[:page]).per(10)
    @posts = Post.includes(:comments).order("created_at DESC").page(params[:page]).per(10)
    @posts = Post.includes(:comments).order("comments.size ASC").page(params[:page]).per(10)
    @posts = Post.all
    @posts = @posts.page(params[:page]).per(10)

  end

  def show
    #@post = Post.find(params[:post_id])
    #@comments = Comment.find(@post.collect &:id).group_by &:post_id

    @comment = @post.comments.new
    @comments = @post.comments
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
