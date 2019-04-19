class ToppagesController < ApplicationController

  def index
    @fobitow = Fobitow.all
    if params[:button1]
      # ボタン1
      @fobitows = Fobitow.all.order('favorites_count DESC').page(params[:page]).search(params[:search])#.per(10)
    else
      # ボタン2
      @fobitows = Fobitow.all.order('created_at DESC').page(params[:page]).search(params[:search])#.per(10)
    end
  end

  def bookmark
    if logged_in?
      @fobitow = current_user.fobitows.build
    end
  end

end
