class DiagnosisSerializer < BaseSerializer
  attributes :name, :created_at, :updated_at

  has_many :children, if: proc { |_record, params| BaseSerializer.params_include?(params, 'children') }
end
