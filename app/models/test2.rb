require"open-uri"
require"nokogiri"

url="https://weathernews.jp/onebox/35.651604/139.705455/temp=c&q=東京都渋谷区&v=1671e08ac789d4fc5f0ab768a5efeaefce9bb7f9a787bc06a95de1092ab81e4c&lang=ja"

doc=Nokogiri::HTML(open(URI.encode(url)))

#タグ名、クラス名を用いてスクレイピングする
loc=doc.css(".title_now").text #場所
time,weather=doc.css('.sub').text.split(", ") #時刻と天気
tempr=doc.css('.obs_temp_main').text #気温
hmd,prs,wind=doc.css('.table-obs_sub').css('tr').css('.obs_sub_value').text.split(" : ")[1..-1] #湿度、気圧、風速(*)

puts"#{loc}(#{time}現在)"
puts
puts"天気: #{weather}","温度: #{tempr}℃","湿度: #{hmd}","気圧: #{prs}","風速: #{wind}"



url="https://news.yahoo.co.jp/list/?d="+Time.now.strftime("%Y%m%d")+"&mc=f&mp=f"

doc=Nokogiri::HTML(open(url))

for i in 1..10
#ニュースタイトルをスクレイピング
puts doc.xpath("//*[@id='main']/div[1]/div[1]/div[4]/ul/li[#{i}]/a/dl/dt").text
end



url="https://www.amazon.co.jp/gp/top-sellers/books/ref=crw_ratp_ts_books"

doc=Nokogiri::HTML(open(url))

count=0

%w(critical nonCritical).each do |type|
for i in 1..20
#本のタイトルをスクレイピング(取得できない場合はスキップ)
next if (title=doc.xpath("//*[@id='zg_#{type}']/div[#{i}]/div[1]/div/div[2]/a/div").text.strip).empty?
count+=1
puts format("(%2d): %s",count,title)
end
end