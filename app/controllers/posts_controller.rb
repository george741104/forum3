class PostsController < ApplicationController

  before_action :set_post, only:[:move, :show, :like]

  before_action :set_my_post, only:[:edit, :update, :destroy]

  before_action :authenticate_user!

  def index

    #@posts = Post.order("id DESC")
    @posts = Post.rank(:row_order).all

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

    respond_to do |format|
      format.html # index.html.erb
      format.xml {
        render :xml => @posts.to_xml
      }
      format.json {
        render :json => @posts.to_json
      }
      format.atom {
        @feed_title = "My event list"
      } # index.atom.builder
    end



  end

  def show

    if params[:cid]
      @comment = @post.comments.find( params[:cid] )
    else
      @comment = @post.comments.new
    end
    @user = @post.user
    @comments = @post.comments.page(params[:page]).per(10)

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save # TODO: handle validation failed!
      flash[:notice] = "Post is successfully created!"
      redirect_to posts_path
    else
      flash[:alert] = "Title and content can't be blank."
      redirect_to :back
    end


  end

  def edit
  end

  def update

    if params[:_remove_logo] =="1"
      @post.logo=nil
      flash[:alert] = "Picture is removed!"
    end


    if @post.update(post_params) # TODO: handle validation failed!
      flash[:notice] = "Post was successfully updated!"
      redirect_to posts_path
    else
      flash[:alert] = "Title and Content can't be blank!"
    end
  end

  def destroy
    @post.destroy

    flash[:alert] = "Post was deleted"

    respond_to do |format|
      format.html {redirect_to posts_path}
      format.js
    end


  end

  def add_favorite
    @fav = current_user.favorites.find_by_post_id(params[:id])
    current_user.favorites.create(:post_id=>params[:id])
    redirect_to :back
  end

  def remove_favorite
    @fav = current_user.favorites.find_by_post_id(params[:id])
    @fav.destroy
    redirect_to :back
  end



  def like
    @likes_count = @post.likes.count.to_i
    l = get_like
    if l
      l.destroy
      @likes_count-=1
    else
      current_user.likes.create(:post_id=>params[:id])
      @likes_count+=1
    end
    respond_to do |format|
      format.html {redirect_to post_path(@post)}
      format.js
    end

  end


  def move
    @post.row_order_position = params[:position]
    @post.save!

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
    params.require(:post).permit(:title, :logo, :content,:tag_list, :category_ids => [])
  end
  def get_like
    current_user.likes.find_by_post_id(params[:id])
  end
end
