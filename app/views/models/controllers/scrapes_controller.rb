class ScrapesController < ApplicationController

  def show
    @user = User.find(params[:id])
    @fobitows = @user.fobitows.order('created_at DESC').page(params[:page]).per(15)
    counts(@user)
  end
  
end