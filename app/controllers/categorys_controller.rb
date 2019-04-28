class CategorysController < ApplicationController
  
  def index
    @comments = Comment.all.order('created_at desc').page(params[:comme_page]).per(5)
    @co = Fobitow.group(:category).order('count_category desc').count(:category)
  
    @fobitow = Fobitow.all
    if params[:button1]
      @fobitows = Fobitow.all.order('favorites_count DESC').search(params[:search]).page(params[:fobi_page]).per(15)
    else if params[:button2]
      @fobitows = Fobitow.all.order('created_at DESC').search(params[:search]).page(params[:fobi_page]).per(15)
    else
      params[:button2] = '新着'
      @fobitows = Fobitow.all.order('created_at DESC').search(params[:search]).page(params[:fobi_page]).per(15)
    end
    end
  end
  
  def show
    @fobitow = Fobitow.all
    @comment = Comment.new
    @user = User.all    

    @comments = Comment.all.order('created_at desc').page(params[:comme_page]).per(5)
    @co = Fobitow.group(:category).order('count_category desc').count(:category)

    if params[:button1]
      @fobitows = Fobitow.where(category: params[:category]).order('favorites_count DESC').search(params[:search]).page(params[:fobi_page]).per(15)
    else if params[:button2]
      @fobitows = Fobitow.where(category: params[:category]).order('created_at DESC').search(params[:search]).page(params[:fobi_page]).per(15)
    else
      params[:button2] = '新着'
      fobitow = Fobitow.all
      @fobitows = Fobitow.where(category: params[:category]).order('created_at DESC').search(params[:search]).page(params[:fobi_page]).per(15)
    end
    end
  end
end