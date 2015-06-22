class CommentsController < ApplicationController
  before_action :set_comment, :only:[:show, :edit, :update, :destroy]


  def index
    @comments = Comment.all
  end
  private
  def set_comment
    @comments = Comment.find(params[:id])
  end

end
