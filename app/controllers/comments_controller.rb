class CommentsController < ApplicationController
  before_action :set_comment, only:[:show, :edit, :update, :destroy]


  def index
    @comments = Comment.all

  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post_id = @post
    @comment.user_id = current_user.id
    @comment.save

    redirect_to post_path(@post)
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end
  def comment_params
    params.require(:comment).permit(:content)
  end
end

