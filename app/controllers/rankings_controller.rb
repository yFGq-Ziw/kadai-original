class RankingsController < ApplicationController

  def follow
    @ranking_counts = Follow.ranking
    #@users = User.find(@ranking_counts.keys)
    @users = User.all.page(params[:page])#.per(4)
  end
end
