class CommentsController < ApplicationController
  before_action :set_comment, only:[:show, :edit, :update, :destroy]
  before_action :find_post#, except: [:destroy]

  def index

    @comments = Comment.post

  end

  def count
    @comments = Comment.all
    @comments = @comments.count.to_i
  end

  def create

    @comment = Comment.new(comment_params)

    @comment.post = @post
    @comment.user = current_user

    @comment.save

    redirect_to post_path(@post)
  end

  def edit

  end

  def update
    @comment.update(comment_params)
    redirect_to post_path(@post)
  end
  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end


  private
  def set_comment
    @comment = Comment.find(params[:id])
  end
  def find_post
    @post = Post.find(params[:post_id])
  end
  def comment_params
    params.require(:comment).permit(:content)
  end
end

