class Like < ApplicationRecord
    belongs_to :fobitow, counter_cache: :likes_count
  belongs_to :user
end
