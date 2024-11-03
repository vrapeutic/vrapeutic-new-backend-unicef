class ChildSerializer < BaseSerializer
  attributes :name, :email, :age, :created_at, :updated_at

  attribute :photo_url do |child|
    child.photo_url
  end

  has_many :diagnoses, if: proc { |_record, params| BaseSerializer.params_include?(params, 'diagnoses') && params[:center_id] } do |child, params|
    diagnoses_ids = child.child_diagnoses.where(center_id: params[:center_id]).pluck(:diagnosis_id)
    Diagnosis.where(id: diagnoses_ids)
  end
  has_many :centers, if: proc { |_record, params| BaseSerializer.params_include?(params, 'centers') }
  has_many :software_modules, if: proc { |_record, params| BaseSerializer.params_include?(params, 'software_modules') }
  has_many :sessions, if: proc { |_record, params| BaseSerializer.params_include?(params, 'sessions') }
  has_many :doctors, if: proc { |_record, params| BaseSerializer.params_include?(params, 'doctors') }
end
