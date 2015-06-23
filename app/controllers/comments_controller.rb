class CommentsController < ApplicationController
  before_action :set_comment, only:[:show, :edit, :update, :destroy]


  def index
    @post = Post.find(params[:post_id])
    @comments = Comment.post

  end
  def count
    @comments = Comment.all
    @comments = @comments.count.to_i
  end
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)

    @comment.post = @post
    @comment.user = current_user

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

