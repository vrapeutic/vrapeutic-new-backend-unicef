class Headset < ApplicationRecord
  belongs_to :center

  validates :name, presence: true
  validates :model, presence: true
  validates :brand, presence: true
  validates :key, presence: true, uniqueness: true
  
end
