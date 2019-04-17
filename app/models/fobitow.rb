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
end