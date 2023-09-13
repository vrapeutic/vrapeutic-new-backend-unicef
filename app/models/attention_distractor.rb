class AttentionDistractor < ApplicationRecord
  validates :name, presence: true
  validates :time_following_it_seconds, presence: true
  
  belongs_to :attention_performance

  
end
