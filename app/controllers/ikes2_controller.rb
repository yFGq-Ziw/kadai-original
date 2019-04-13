# 全てajax用
class LikesController < ApplicationController
  before_action :set_fobitow
  def create
    @like = Like.create(user_id: current_user.id, fobitow_id: params[:fobitow_id])
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, fobitow_id: params[:fobitow_id])
    like.destroy
  end

  private

  def set_tweet
    @fobitow = Fobitow.find(params[:fobitow_id])
  end
end
