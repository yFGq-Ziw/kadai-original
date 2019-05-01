class Favorite < ApplicationRecord
  belongs_to :user

  # ajaxコメントアウト部
#  belongs_to :fobitow
  # ここまで
  
  # ajax追加部
  belongs_to :fobitow, counter_cache: :favorites_count
  # ここまで
  def self.ranking
#    self.group(:fobitow_id).order('count_fobitow_id DESC').limit(10).count(:fobitow_id)
    self.group(:fobitow_id).order('count_fobitow_id DESC').count(:fobitow_id)
  end
end