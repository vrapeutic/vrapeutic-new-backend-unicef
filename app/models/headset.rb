class Headset < ApplicationRecord
  validates :brand, presence: true
  validates :key, presence: true, uniqueness: true

  belongs_to :center
  has_many :sessions, dependent: :destroy

  scope :active, -> {
                   includes(:sessions)
                     .where(sessions: { ended_at: nil })
                     .or(where('sessions.ended_at > ?', Time.now)).distinct
                 }
  scope :inactive, -> {
    where.not(id: Headset.active.select(:id))
  }

  before_validation :lowercase_name

  private

  def lowercase_name
    self.name = name.downcase if name
  end
end
