class CommentsController < ApplicationController

  before_action :find_post
  before_action :set_my_comment, only:[:update, :destroy]

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    @comment.save # handle validation failed
    @comment.post.touch

    redirect_to post_path(@post)
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

