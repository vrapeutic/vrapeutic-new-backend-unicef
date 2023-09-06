class ChildDoctor < ApplicationRecord
  belongs_to :doctor
  belongs_to :child
end
