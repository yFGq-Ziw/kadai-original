module FobitowsHelper
  def render_with_tags(name)
    name.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/post/tag/#{word.delete("#")}"}.html_safe
  end 
end