class ChildDiagnosis < ApplicationRecord
  belongs_to :child
  belongs_to :diagnosis
  belongs_to :center, optional: true
end
