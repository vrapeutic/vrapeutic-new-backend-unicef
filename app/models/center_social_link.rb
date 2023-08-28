class CenterSocialLink < ApplicationRecord
  belongs_to :center

  enum link_type: { facebook: 0, twitter: 1, instagram: 2 }

  validates :link, presence: true, uniqueness: true

  before_validation :lowercase_link

  private 
  def lowercase_link
    self.link = self.link.downcase
  end
end
