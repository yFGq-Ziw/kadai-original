class ToppagesController < ApplicationController
  def index
    if logged_in?
      @fobitow = current_user.fobitows.build
      @fobitows = current_user.feed_fobitows.order('created_at DESC').page(params[:page])
    end
  end
end