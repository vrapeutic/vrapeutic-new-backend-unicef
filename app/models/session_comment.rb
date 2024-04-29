class SessionComment < ApplicationRecord
  belongs_to :session

  before_validation :lowercase_name

  validates :name, presence: true

  private

  def lowercase_name
    self.name = name.downcase if name
  end
end
