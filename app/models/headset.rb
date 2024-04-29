class Headset < ApplicationRecord
  validates :brand, presence: true
  validates :key, presence: true, uniqueness: true

  belongs_to :center
  has_many :sessions, dependent: :destroy

  before_validation :lowercase_name

  private

  def lowercase_name
    self.name = name.downcase if name
  end
end
