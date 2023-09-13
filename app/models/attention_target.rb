class AttentionTarget < ApplicationRecord
  validates :start_time, presence: true
  validates :hit_time, presence: true
  
  belongs_to :attention_performance
  
end
