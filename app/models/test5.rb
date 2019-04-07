#検索ワードはコマンドライン引数で指定する
require 'nokogiri'
require 'open-uri'

abort"ワードが指定されていません" unless ARGV[0]

query=ARGV.join(" ")
url="https://www.google.com/search?q=#{query}&oe=utf-8&hl=ja"

doc=Nokogiri::HTML(open(URI.encode(url)))

#結果件数をスクレイピング
puts format"結果件数: %s",doc.xpath("//*[@id='resultStats']/text()")
puts
#検索結果をスクレイピング
doc.xpath('//h3/a').each_with_index do |link,idx|
puts format"(%2d)%s",idx+1,link.content
end