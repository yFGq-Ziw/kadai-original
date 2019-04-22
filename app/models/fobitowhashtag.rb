class FobitowHashtag < ApplicationRecord
  belongs_to :fobitow
  belongs_to :tag
  validates  :fobitow_id, presence: true
  validates  :tag_id,   presence: true
end