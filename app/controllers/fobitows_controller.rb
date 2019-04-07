class FobitowsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    @fobitow = current_user.fobitows.build(fobitow_params)
    if @fobitow.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @fobitows = current_user.fobitows.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @fobitow.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def fobitow_params
    params.require(:fobitow).permit(:content)
  end

  def correct_user
    @fobitow = current_user.fobitows.find_by(id: params[:id])
    unless @fobitow
      redirect_to root_url
    end
  end
end