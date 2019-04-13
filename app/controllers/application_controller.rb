class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_filter :set_request_from
  #helper_method :return_back

  # どこのページからリクエストが来たか保存しておく
  def set_request_from
    if session[:request_from]
      @request_from = session[:request_from]
    end
    # 現在のURLを保存しておく
    session[:request_from] = request.original_url
  end
  
  # 前の画面に戻る
  def return_back
    if request.referer
      redirect_to :back and return true
    elsif @request_from
      redirect_to @request_from and return true
    end
  end
  
  include SessionsHelper

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  def counts(user)
    @count_fobitows = user.fobitows.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_likes = user.likes.count
  end
  before_filter :set_request_from
end