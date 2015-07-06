class CommentsController < ApplicationController

  before_action :find_post
  before_action :set_my_comment, only:[:update, :destroy]

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save # handle validation failed
      flash[:notice] = "Comment sent"
    else
      flash[:alert] = "Content can't be blank"
    end
    @comment.post.touch
    redirect_to post_path(@post)
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "Comment updated"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Content can't be blank"
      redirect_to post_path(@post)
    end
  end

  def destroy
    @comment.destroy
      respond_to do |format|
      format.html{redirect_to post_path(@post)}
      format.js
    end
  end

  private

  def set_my_comment
    @comment = current_user.comments.find(params[:id])
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end

