class Session < ApplicationRecord
  belongs_to :center
  belongs_to :headset
  belongs_to :child

  enum evaluation: {very_bad: 0, bad: 1, fair: 2, good: 3, very_good: 4, excellent: 5}
end
