class Headset < ApplicationRecord

  validates :name, presence: true
  validates :model, presence: true
  validates :brand, presence: true
  validates :key, presence: true, uniqueness: true

  belongs_to :center
  has_many :sessions, dependent: :destroy

  

  before_validation :lowercase_name

  private 

  def lowercase_name
    self.name = self.name.downcase if self.name
  end
end
