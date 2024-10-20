class Headset < ApplicationRecord
  default_scope { order(model: :asc) }

  include Discard::Model

  # constant variables
  RANSACKABLE_ATTRIBUTES = %w[id version name brand model key center_id created_at updated_at].freeze
  RANSACKABLE_ASSOCIATIONS = %w[center sessions].freeze

  belongs_to :center
  has_many :sessions, dependent: :destroy

  validates :model, presence: true, unless: :discarded_at?
  validates :key, presence: true, uniqueness: true, unless: :discarded_at?

  scope :active, -> {
                   includes(:sessions)
                     .where(sessions: { ended_at: nil })
                     .or(where('sessions.ended_at > ?', Time.now)).kept.distinct
                 }
  scope :inactive, -> {
    where.not(id: Headset.active.select(:id)).kept
  }

  before_validation :lowercase_name

  private

  def lowercase_name
    self.name = name.downcase if name
  end
end
