class ChildDiagnosisSerializer < BaseSerializer
  attributes :child_id, :diagnosis_id, :created_at, :updated_at

  has_one :child, if: proc { |_record, params| BaseSerializer.params_include?(params, 'child') }
  has_one :diagnosis, if: proc { |_record, params| BaseSerializer.params_include?(params, 'diagnosis') }
end
