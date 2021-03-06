class User < ApplicationRecord

  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 12 }
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :comment, length: { maximum: 80 }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  mount_uploader :image, ImageUploader

  has_many :fobitows
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user

  has_many :favorites, dependent: :destroy
  has_many :likes, through: :favorites, source: :fobitow
  has_many :create_images
  
  has_many :comments

  #カラムの名前をmount_uploaderに指定
  #mount_uploader :image, ImageUploader
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_fobitows
    Fobitow.where(user_id: self.following_ids + [self.id])
  end
  
  def fav(fobitow)
    favorites.find_or_create_by(fobitow_id: fobitow.id)
  end
  
  def unfav(fobitow)
    favorite = favorites.find_by(fobitow_id: fobitow.id)
    favorite.destroy if favorite
  end

  def likes?(fobitow)
    likes.include?(fobitow)
  end
  
    def self.search(search)
      return User.all unless search
      User.where(['name LIKE ? or comment LIKE ?', "%#{search}%", "%#{search}%"])
    end
end