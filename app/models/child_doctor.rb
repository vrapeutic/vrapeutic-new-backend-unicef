class ChildDoctor < ApplicationRecord
  belongs_to :doctor
  belongs_to :child
  belongs_to :center
end
