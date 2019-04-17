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
    
      @fobitow.title = doc.title
    
      num = 0
      begin
      #doc.xpath('html').each do |node|
        num += 0
        puts num

          #<%= image_tag node.css('img').attribute('src').value
          #<%= node.css('h3').inner_text
          #<%= image_tag node.css('a').attribute('href').value
        if num == 0 then
          break
        end
      end while num < 0

    rescue => e
      #puts e 例外メッセージ表示
      #@fobitow.title = e
      #render toppages_bookmark_path        
    end
      if @fobitow.save
        flash[:success] = 'ブックマークを投稿しました。'
        redirect_to url_for(controller: 'categorys', action: 'show', category: @fobitow.category)
        #redirect_to toppages_bookmark_path
    
      else
        @fobitows = current_user.fobitows.order('created_at DESC').page(params[:page])
        flash.now[:danger] = 'ブックマークの投稿に失敗しました。'
        render toppages_bookmark_path
      end
  end

  def destroy
    @fobitow.destroy
    flash[:success] = 'ブックマークを削除しました。'
    redirect_back(fallback_location: root_path)
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