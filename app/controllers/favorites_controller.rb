class FavoritesController < ApplicationController

  def new
    @favorite = Favorite.new
    render :create
  end

  def create
    @favorite = @post.favorite.new(params_favorite)
    @user = current_user
    @favorite.save
    raise
    redirect_to :back #post_path(@post)
  end


private

  def params_favorite
    params.require(:favorites).permit(:post_id, :user_id)
  end



end
