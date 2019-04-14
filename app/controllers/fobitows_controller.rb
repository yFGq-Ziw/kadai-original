class FobitowsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    @fobitow = current_user.fobitows.build(fobitow_params)
    if @fobitow.save
      flash[:success] = 'ブックマークを投稿しました。'
      redirect_to url_for(controller: 'categorys', action: 'show', category: @fobitow.category)
    else
      @fobitows = current_user.fobitows.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'ブックマークの投稿に失敗しました。'
      render toppages_bookmark_path
    end
  end

  def destroy
    @fobitow.destroy
    flash[:success] = 'ブックマークを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private
# ストロング
  def fobitow_params
    params.require(:fobitow).permit(:content, :title, :category)
  end

  def correct_user
    @fobitow = current_user.fobitows.find_by(id: params[:id])
    unless @fobitow
      redirect_to root_url
    end
  end
end