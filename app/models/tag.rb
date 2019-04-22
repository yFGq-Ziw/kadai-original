class Tag < ApplicationRecord
  validates :name, presence: true, length: {maximum:99}
  has_and_belongs_to_many :fobitows, dependent: :destroy
end
