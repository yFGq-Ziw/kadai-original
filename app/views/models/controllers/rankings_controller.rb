class RankingsController < ApplicationController

  def follow
    @co = Fobitow.group(:category).order('count_category desc').count(:category)

    #@users = User.find(@ranking_counts.keys)
    @users = User.all.page(params[:page]).search(params[:search]).per(15)
    @ranking_counts = Follow.ranking
  end
end