class Headset < ApplicationRecord
  belongs_to :center

  validates :name, presence: true
  validates :model, presence: true
  validates :brand, presence: true
  validates :key, presence: true, uniqueness: true
  

  before_validation :lowercase_name

  private 

  def lowercase_name
    self.name = self.name.downcase if self.name
  end
end
