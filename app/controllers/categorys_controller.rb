class CategorysController < ApplicationController

  def show
    if params[:button1]
      @fobitows = Fobitow.where(category: params[:category]).order('favorites_count DESC').page(params[:page]).search(params[:search])#.per(10)
    else if params[:button2]
      @fobitows = Fobitow.where(category: params[:category]).order('created_at DESC').page(params[:page]).search(params[:search])#.per(10)
    else 
      params[:button2] = '新着'
      @fobitows = Fobitow.where(category: params[:category]).order('created_at DESC').page(params[:page]).search(params[:search])#.per(10)
    end
    end
  end
end