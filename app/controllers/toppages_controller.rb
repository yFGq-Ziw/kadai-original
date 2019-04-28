class ToppagesController < ApplicationController

  def index
    @co = Fobitow.group(:category).order('count_category desc').count(:category)
#    @comments = Comment.all.order('created_at desc').page(params[:comme_page]).per(5)
#      @fobitow = Fobitow.new
#      @fobitows = @user.fobitows.order('created_at DESC').page(params[:page]).search(params[:search])
#    @fobitow = Fobitow.all
#    if params[:button1]
#      @fobitows = Fobitow.all.order('favorites_count DESC').search(params[:search]).page(params[:fobi_page]).per(15)
#      counts(@user)
#    else if params[:button2]
#      @fobitows = Fobitow.all.order('created_at DESC').search(params[:search]).page(params[:fobi_page]).per(15)
#      counts(@user)
#    else
#      params[:button2] = '新着'
#      @fobitows = Fobitow.all.order('created_at DESC').search(params[:search]).page(params[:fobi_page]).per(15)
#    end
#    end
  end

  def bookmark
    if logged_in?
      @fobitow = current_user.fobitows.build
    end
  end

end
