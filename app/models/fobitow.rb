class Fobitow < ApplicationRecord
  belongs_to :user
  has_many :users, through: :favorites
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
#  has_and_belongs_to_many :tags

  validates :content, length: { maximum: 300 }, presence: true
                      #format: /\A#{URI::regexp(%w(http https))}\z/,
                      #uniqueness: true
#  validates :title, presence: true#, length: { maximum: 150 }
  validates :category, length: { maximum: 12 }#, presence: true
  validates :likes_count, length: { maximum: 250 }

#  enum status:{nonreleased: 0, released: 1}

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
end