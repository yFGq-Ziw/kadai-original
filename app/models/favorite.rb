class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :fobitow#, counter_cache: :likes_count

  def self.ranking
    self.group(:fobitow_id).order('count_fobitow_id DESC').limit(10).count(:fobitow_id)
  end
end