class Session < ApplicationRecord
  # constant variables
  RANSACKABLE_ATTRIBUTES = %w[id duration evaluation is_verified ended_at session_id note center_id headset_id child_id created_at updated_at].freeze
  RANSACKABLE_ASSOCIATIONS = %w[center headset child].freeze

  belongs_to :center
  belongs_to :headset
  belongs_to :child

  validates :session_id, presence: true, uniqueness: true, unless: :new_record?
  mount_uploader :evaluation_file, FileUploader

  enum evaluation: { poor: 0, average: 1, good: 2, very_good: 4, excellent: 5 }, _prefix: true

  validates_numericality_of :duration, allow_nil: true, greater_than_or_equal_to: 0
  validates_numericality_of :vr_duration, allow_nil: true, greater_than_or_equal_to: 0
  validates :ended_at, date: { before: proc { Time.now + 1.minute } }, allow_nil: true

  has_many :session_doctors, dependent: :destroy
  has_many :doctors, through: :session_doctors
  has_many :session_modules, dependent: :destroy
  has_many :software_modules, through: :session_modules
  has_many :session_comments, dependent: :destroy

  after_create :set_session_id
  after_create :free_blocked_headset_job

  private

  def set_session_id
    update(session_id: generated_session_id)
  end

  def generated_session_id
    "#{id}-#{center&.id}-#{child&.id}"
  end

  def free_blocked_headset_job
    FreeBlockedHeadsetWorker.perform_at(90.minutes.from_now, self.id)
  end
end
