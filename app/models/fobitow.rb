class Fobitow < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 300 },
                      format: /\A#{URI::regexp(%w(http https))}\z/,
                      uniqueness: true
  validates :title, length: { maximum: 150 }
  validates :category, length: { maximum: 20 }, presence: true

  has_many :users, through: :favorites
  has_many :favorites, dependent: :destroy

# ajax
  def favorite_user(user_id)
    favorites.find_by(user_id: user_id)
  end
# ajaxここまで

  # search機能
  def self.search(search)

    if search && search != ""
      words = search.to_s.split(" ")
      columns = ["title", "likes_count"]
      query = []
      result = []
 
      columns.each do |column|
        query << ["#{column} LIKE ?"]
      end
 
      words.each_with_index do |w, index|
        if index == 0
          result[index] = Fobitow.where([query.join(" OR "), "%#{w}%",  "%#{w}%"])
        else
          result[index] = result[index-1].where([query.join(" OR "), "%#{w}%",  "%#{w}%"])
        end
      end
      return result[words.length-1]
    else
      Fobitow.all
    end
  end
end