class Admin::PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin


  # layout "admin"

  def index
    @posts = Post.all
    @categories = Category.all
    @posts = @posts.page(params[:page]).per(10)

    if params[:category_ids]
      @posts = @posts.joins(:category_postships).where( "category_postships.category_id" => params[:category_ids] )
    end

  end



  protected

  def check_admin
    unless current_user.admin?
      raise ActiveRecord::RecordNotFound
    end
  end

end
