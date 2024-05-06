class Session < ApplicationRecord
  belongs_to :center
  belongs_to :headset
  belongs_to :child

  validates :session_id, presence: true, uniqueness: true, unless: :new_record?

  enum evaluation: { very_bad: 0, bad: 1, fair: 2, good: 3, very_good: 4, excellent: 5 }

  validates_numericality_of :vr_duration, allow_nil: true, greater_than: 0

  has_many :session_doctors, dependent: :destroy
  has_many :doctors, through: :session_doctors
  has_many :session_modules, dependent: :destroy
  has_many :software_modules, through: :session_modules
  has_many :session_comments, dependent: :destroy

  after_create :set_session_id

  def generated_session_id
    "#{id}-#{center&.id}-#{child&.id}"
  end

  private

  def set_session_id
    update(session_id: generated_session_id)
  end
end
