class FobitowsController < ApplicationController

  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  require 'open-uri'
  require 'nokogiri'
  require 'uri'

  def create
    @fobitow = current_user.fobitows.build(fobitow_params)
    charset = nil
    begin
      html = open(@fobitow.content) do |f|
        charset = f.charset
        f.read
        # f.last_modified
      end
      doc = Nokogiri::HTML.parse(html, nil, charset)

        @fobitow.title = doc.title.byteslice(0,512).scrub('')

        @fobitow.likes_count = doc.xpath('h3').inner_text.byteslice(0,512).scrub('')
        
        if @fobitow.likes_count = :empty
          @fobitow.likes_count = doc.xpath('//section/p[1]').inner_text.byteslice(0,512).scrub('')
        end

#      begin
#      doc.xpath('//div').each do |node|
#        num += 0
#        puts num
#          @fobitow.likes_count = doc.at(:text).inner_text
#         if num == 0 then
#            break
#          end
#        end while num < 0

    rescue => e
      puts e #例外メッセージ表示
      @fobitow.title = e
    end
      if @fobitow.save
        flash[:success] = 'ブックマークを投稿しました。'
        redirect_to url_for(controller: 'categorys', action: 'show', category: @fobitow.category)
        #redirect_to toppages_bookmark_path
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

  private
  
# ストロング
  def fobitow_params
    params.require(:fobitow).permit(:content, :title, :category)
  end

  def correct_user
    @fobitow = current_user.fobitows.find_by(id: params[:id])
    unless @fobitow
      redirect_to root_url
    end
  end
end