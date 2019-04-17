class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  # ajaxへ変更にてコメントアウト
#  def create
#    fobitow = Fobitow.find(params[:fobitow_id])
#    current_user.fav(fobitow)
#    flash[:success] = 'お気に入りに追加しました。'
#    redirect_back(fallback_location: root_path)
#  end

#  def destroy
#    fobitow = Fobitow.find(params[:fobitow_id])
#    current_user.unfav(fobitow)
#    flash[:success] = 'お気に入りを解除しました。'
#    redirect_back(fallback_location: root_path)
#  end

  def create
    @favorite = Favorite.create(user_id: current_user.id, fobitow_id: params[:fobitow_id])
    @favorites = Favorite.where(fobitow_id: params[:fobitow_id])
    @fobitow = Fobitow.find(params[:fobitow_id])
  end

  def destroy
    favorite = Favorite.find_by(user_id: current_user.id, fobitow_id: params[:fobitow_id])
    favorite.destroy
    @favorites = Favorite.where(fobitow_id: params[:fobitow_id])
    @fobitow = Fobitow.find(params[:fobitow_id])
  end

end