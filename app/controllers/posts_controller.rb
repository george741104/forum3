class PostsController < ApplicationController

  before_action :set_post, only:[:show]
  before_action :set_my_post, only:[:edit, :update, :destroy]

  before_action :authenticate_user!

  def index
    @posts = Post.all

    if params[:category_ids]
      @posts = @posts.joins(:category_postships).where( "category_postships.category_id" => params[:category_ids] )
    end

    if params[:order] == "updated_at"
      @posts = @posts.order("updated_at DESC")
    elsif params[:order] == "comments_count"
      @posts = @posts.order("comments_count DESC")
    else
      @posts = @posts.order("id ASC")
    end

    @categories = Category.all

    @posts = @posts.page(params[:page]).per(10)
  end

  def show
    if params[:cid]
      @comment = @post.comments.find( params[:cid] )
    else
      @comment = @post.comments.new
    end

    @comments = @post.comments.page(params[:page]).per(10)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    @post.save # TODO: handle validation failed!

    redirect_to posts_path
  end

  def edit
  end

  def update
    @post.update(post_params) # TODO: handle validation failed!

    redirect_to posts_path
  end

  def destroy
    @post.destroy

    flash[:alert] = "Post was deleted"
    redirect_to :back
  end

  private

  def set_my_post
    @post = current_user.posts.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :category_ids => [])
  end
end
