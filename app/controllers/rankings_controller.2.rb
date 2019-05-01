class RankingsController < ApplicationController
  def follow
    @co = Fobitow.group(:category).order('count_category desc').count(:category)
    @users = User.all.search(params[:search])
    @ranking_counts = Follow.ranking
    @u_kazu = @users.count
    @users = User.all.order('@ranking_counts desc').search(params[:search]).page(params[:page]).per(24)
  end
end