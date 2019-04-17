class Follow < Relationship
  def self.ranking
    self.group(:follow_id).order('count_follow_id DESC').count(:follow_id)
  end
end
