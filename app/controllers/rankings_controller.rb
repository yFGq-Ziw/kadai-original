class RankingsController < ApplicationController
  def follow
    @co = Fobitow.group(:category).order('count_category desc').count(:category)
    @users = User.all.search(params[:search])
    @kazu = @users.count
    @users = User.all.search(params[:search]).order('created_at desc').page(params[:page]).per(24)
    @ranking_counts = Follow.ranking
  end
end