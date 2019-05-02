class ToppagesController < ApplicationController
  def index
    @co = Fobitow.group(:category).order('count_category desc').count(:category)
  end

  def bookmark
    if logged_in?
      @fobitow = current_user.fobitows.build
    end
  end
end