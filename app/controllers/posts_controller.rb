class PostsController < ApplicationController
  before_action :set_post, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    # sort_by = (params[:order] == 'title') ? 'title' : 'created_at'
    # @posts = Post.order(sort_by).page(params[:page]).per(10)
    # @posts = Post.includes(:comments).order("created_at DESC").page(params[:page]).per(10)
    # @posts = Post.includes(:comments).order("comments.size DESC").page(params[:page]).per(10)
    # @posts = Post.all
    # @posts = @posts.page(params[:page]).per(10)
    if params[:order] == "created_at"
      @posts = Post.includes(:comments).order("updated_at DESC")
    else
      @posts = Post.order("id ASC")
    end

    @posts = @posts.all
    @posts = @posts.page(params[:page]).per(10)
  end
  def show
    #@post = Post.find(params[:post_id])
    #@comments = Comment.find(@post.collect &:id).group_by &:post_id

    if params[:cid]
      @comment = @post.comments.find( params[:cid] )
    else
      @comment = @post.comments.new
    end

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
