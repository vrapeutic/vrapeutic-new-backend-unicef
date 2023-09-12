class SessionComment < ApplicationRecord
  belongs_to :session

  before_validation :lowercase_name

  validates :name, presence: true

  private 
  def lowercase_name
    self.name = self.name.downcase if self.name
  end
end
