class AttentionPerformance < ApplicationRecord
  has_one :performance, as: :performanceable, dependent: :destroy
  has_many :attention_targets, dependent: :destroy
  has_many :attention_interruptions, dependent: :destroy
  has_many :attention_distractors, dependent: :destroy
end
