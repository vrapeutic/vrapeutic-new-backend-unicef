class Session < ApplicationRecord
  belongs_to :center
  belongs_to :headset
  belongs_to :child
end
