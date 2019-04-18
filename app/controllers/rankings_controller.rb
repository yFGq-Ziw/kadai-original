class RankingsController < ApplicationController

  def follow
    #@users = User.find(@ranking_counts.keys)
    @users = User.all.page(params[:page])#.per(4)
    @ranking_counts = Follow.ranking
  end
end