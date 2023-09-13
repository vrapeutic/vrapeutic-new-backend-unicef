class AttentionInterruption < ApplicationRecord
  validates :duration_seconds, presence: true
  
  belongs_to :attention_performance
end
