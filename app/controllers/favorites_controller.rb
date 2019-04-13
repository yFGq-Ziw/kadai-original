class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    fobitow = Fobitow.find(params[:fobitow_id])
    current_user.fav(fobitow)
    flash[:success] = 'お気に入りに追加しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    fobitow = Fobitow.find(params[:fobitow_id])
    current_user.unfav(fobitow)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end