class ToppagesController < ApplicationController
#before_action :set_fobitow, only: [:index, :bookmark]

  def index
#    if logged_in?
#      @fobitow = current_user.fobitows.build
#      @fobitows = current_user.feed_fobitows.order('created_at DESC').page(params[:page])
#    else
      @fobitow = Fobitow.all
      @fobitows = Fobitow.all.order('created_at DESC').page(params[:page])
#    end
  end

  def bookmark
    if logged_in?
      @fobitow = current_user.fobitows.build
      @fobitows = current_user.fobitows.order('created_at DESC').page(params[:page])
#    else
#      @fobitow = Fobitow.all
#      @fobitows = Fobitow.all.order('created_at DESC').page(params[:page]).per(10)
    end
  end
  
  private

  def set_fobitow
#      @fobitow = Fobitow.all
  end
end  