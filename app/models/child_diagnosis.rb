class ChildDiagnosis < ApplicationRecord
  belongs_to :child
  belongs_to :diagnosis
end
