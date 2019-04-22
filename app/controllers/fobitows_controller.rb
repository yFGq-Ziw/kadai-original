class FobitowsController < ApplicationController

  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
    @fobitow = Fobitow.find(params[:id])
  end
  
  def create
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

      num = 0
      begin
        doc.css("h3").each do |title|
          num += 0
          puts num
          puts title.text
            @image = title.text.byteslice(0,255).scrub('')# + "..."
            if num == 0 then
              break
            end
          end
      end while num < 0

    if @image = ''
      num = 0
      begin
        doc.css("span[2]").each do |title|
          num += 0
          puts num
          puts title.text
            @image = title.text.byteslice(0,255).scrub('')# + "..."
            if num == 0 then
              break
            end
          end
      end while num < 0
    end

    if @image = ''
      num = 0
      begin
        doc.css("p[3]").each do |title|
          num += 0
          puts num
          puts title.text
            @image = title.text.byteslice(0,255).scrub('')# + "..."
            if num == 0 then
              break
            end
          end
      end while num < 0
    end

      num = 0
      begin
        doc.css("p[2]").each do |title|
          num += 0
          puts num
          puts title.text
            @likes = title.text.byteslice(0,255).scrub('')# + "..."
            if num == 0 then
              break
            end
          end
      end while num < 0

    if @likes = ''
      num = 0
      begin
        doc.css("p").each do |title|
          num += 0
          puts num
          puts title.text
            @likes = title.text.byteslice(0,255).scrub('')# + "..."
            if num == 0 then
              break
            end
          end
      end while num < 0
    end

    if @likes = ''
      num = 0
      begin
        doc.css("a[2]").each do |title|
          num += 0
          puts num
          puts title.text
            @likes = title.text.byteslice(0,255).scrub('')# + "..."
            if num == 0 then
              break
            end
          end
      end while num < 0
    end
      #category
      num = 0
      begin
        doc.css("span").each do |title|
          num += 0
          puts num
          puts title.text
            @category = title.text.byteslice(0,255).scrub('')# + "..."
            if num == 0 then
              break
            end
          end
      end while num < 0

    if @category = ''
      num = 0
      begin
        doc.css("a").each do |title|
          num += 0
          puts num
          puts title.text
            @category = title.text.byteslice(0,255).scrub('')# + "..."
            if num == 0 then
              break
            end
          end
      end while num < 0
    end
    
    if @category = ''
      num = 0
      begin
        doc.css("body[2]").each do |title|
          num += 0
          puts num
          puts title.text
            @category = title.inner_text.byteslice(0,64).scrub('')# + "..."
            if num == 0 then
              break
            end
          end
      end while num < 0
    end    
      @fobitow.likes_count = @image + ' | ' + @category 
      @fobitow.category= @likes
#      @fobitow.image= @image

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
        @fobitows = current_user.fobitows.order('created_at DESC').page(params[:page])
        flash.now[:danger] = 'ブックマークの投稿に失敗しました。'
        redirect_to toppages_bookmark_path
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
  end

  def update
    @fobitow = Fobitow.find(params[:id])
      if @fobitow.update(fobitow_params)
        flash[:success] = 'Bookmark は正常に更新されました'
        redirect_to root_path
        #redirect_to @fobitow
      else
        flash.now[:danger] = 'Bookmark は更新されませんでした'
        render :edit
        #redirect_to @user
      end
  end


#  def tag
#    @user = current_user
#    @tag = Tag.find_by(name: params[:name])
#    @fobitows = @tag.fobitows.build
#    @fobitow  = @tag.fobitows.page(params[:page])
#    @content    = Content.new
#    @contents   = @fobitows.contents
#  end
  
  
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