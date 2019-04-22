class Fobitow < ApplicationRecord
  belongs_to :user
  validates :content, length: { maximum: 300 }#, presence: true
                      #format: /\A#{URI::regexp(%w(http https))}\z/ 
                      #uniqueness: true
#  validates :title, length: { maximum: 150 }
#  validates :category, length: { maximum: 150 }#, presence: true

  has_many :users, through: :favorites
  has_many :favorites, dependent: :destroy

#  has_and_belongs_to_many :tags

# ajax
  def favorite_user(user_id)
    favorites.find_by(user_id: user_id)
  end
# ajaxここまで

  # search機能
  def self.search(search)

    if search && search != ""
      words = search.to_s.split(" ")

      columns = ["title", "likes_count", "category", "content"]

      query = []
      result = []
 
      columns.each do |column|
        query << ["#{column} LIKE ?"]
      end
 
      words.each_with_index do |w, index|
        if index == 0
          result[index] = Fobitow.where([query.join(" OR "), "%#{w}%", "%#{w}%", "%#{w}%",  "%#{w}%"])
        else
          result[index] = result[index-1].where([query.join(" OR "), "%#{w}%", "%#{w}%", "%#{w}%",  "%#{w}%"])
        end
      end
      return result[words.length-1]
    else
      Fobitow.all
    end
  end


  #DBへのコミット直前に実施する
#  after_create do
#    fobitow = Fobitow.find_by(id: self.id)
#    tags  = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
#    tags.uniq.map do |tag|
      #ハッシュタグは先頭の'#'を外した上で保存
#      tag = Tag.find_or_create_by(tagname: tag.downcase.delete('#'))
#      fobitow.tags << tag
#    end
#  end
 
#  before_update do 
#    fobitow = Fobitow.find_by(id: self.id)
#    fobitow.tags.clear
#    tags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
#    tags.uniq.map do |tag|
#      tag = Tag.find_or_create_by(tagname: tag.downcase.delete('#'))
#      fobitow.tags << tag
#    end
#  end

end