class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :fobitow

  validates :body , presence: true
  validates :user_id , presence: true
  validates :body, length: { maximum: 120 }, presence: true

end
