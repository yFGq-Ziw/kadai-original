class FobitowsController < ApplicationController

  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @fobitow = Fobitow.new
    @co = Fobitow.group(:category).order('count_category desc').count(:category)
  end
  
  def show
    @fobitow = Fobitow.find(params[:id])
    @comment = Comment.new
    @user = User.find_by(id: @fobitow.user_id)    
    @co = Fobitow.group(:category).order('count_category desc').count(:category)
#    @fobitows = Fobitow.all
  end
  
  def create
    @co = Fobitow.group(:category).order('count_category desc').count(:category)
  require 'open-uri'
  require 'nokogiri'
  require 'uri'
    @fobitow = current_user.fobitows.build(fobitow_params)
    begin
      url = @fobitow.content
      charset = nil
      html = open(url) do |f|
        charset = f.charset # 文字種別を取得
        f.read # htmlを読み込んで変数htmlに渡す
      end
      doc = Nokogiri::HTML(open(url),nil,"utf-8")
      @fobitow.title = doc.title.byteslice(0,255).scrub('')
    rescue => e
      puts e #例外メッセージ表示
      @fobitow.likes_count = e
    end
      if @fobitow.save
        flash[:success] = '下記の内容でブックマークを投稿しました。追加・修正があれば、編集してUpdateボタンを押してください。'
        #redirect_to url_for(controller: 'categorys', action: 'show', category: @fobitow.category)
        #redirect_back(fallback_location: root_path)
        redirect_to edit_fobitow_path(@fobitow)
      else
        @fobitows = current_user.fobitows.order('created_at DESC').page(params[:page]).per(15)
        flash.now[:danger] = 'ブックマークの投稿に失敗しました。'
        render :index
      end
  end

  def destroy
    @fobitow.destroy
    flash[:success] = 'ブックマークを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def search
    #Viewのformで取得したパラメータをモデルに渡す
    @fobitows = Fobitow.search(params[:search])
  end

  #編集追加
  def edit
    @fobitow = Fobitow.find(params[:id])
    @co = Fobitow.group(:category).order('count_category desc').count(:category)
  end

  def update
    @co = Fobitow.group(:category).order('count_category desc').count(:category)
    @fobitow = Fobitow.find(params[:id])
      if @fobitow.update(fobitow_params)
        flash[:success] = 'Bookmark は正常に更新されました'
        #redirect_to root_path
        redirect_to @fobitow
      else
        flash.now[:danger] = 'Bookmark は更新されませんでした'
        render :edit
        #redirect_to @user
      end
  end

# 公開・非公開
  def release
    fobitow =  Fobitow.find(params[:id])
    fobitow.released! unless fobitow.released?
    redirect_to edit_fobitow_path, notice: 'このブックマークを公開しました'
  end

  def nonrelease
    fobitow =  Fobitow.find(params[:id])
    fobitow.nonreleased! unless fobitow.nonreleased?
    redirect_to edit_fobitow_path, notice: 'このブックマークを非公開にしました'
  end
  
  private
  
# ストロング
  def fobitow_params
    params.require(:fobitow).permit(:content, :title, :category, :likes_count, :image)
  end

  def update_fobitow_params
    params.require(:fobitow).permit(:content, :title, :category, :likes_count, :image)
  end
  
  def correct_user
    @fobitow = current_user.fobitows.find_by(id: params[:id])
    unless @fobitow
      redirect_to root_url
    end
  end
end