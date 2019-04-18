class CategorysController < ApplicationController

  def show
#    if params[:category] = "総合"
#      @fobitows = Fobitow.all.order('created_at DESC').page(params[:page])
#    else
      @fobitows = Fobitow.where(category: params[:category]).order('created_at DESC').page(params[:page])#.per(10)
#    end
  end
  
end