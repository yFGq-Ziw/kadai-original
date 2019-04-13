class RankingsController < ApplicationController
  def favorite
    @ranking_counts = Favorite.ranking
    @fobitows = Fobitow.find(@ranking_counts.keys)
  end
end
