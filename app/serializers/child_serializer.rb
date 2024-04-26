class ChildSerializer < BaseSerializer
  attributes :name, :email, :age, :created_at, :updated_at

  attribute :photo_url do |child|
    child.photo_url
  end

  has_many :diagnoses, if: proc { |_record, params| BaseSerializer.params_include?(params, 'diagnoses') }
  has_many :centers, if: proc { |_record, params| BaseSerializer.params_include?(params, 'centers') }
  has_many :software_modules, if: proc { |_record, params| BaseSerializer.params_include?(params, 'software_modules') }
  has_many :sessions, if: proc { |_record, params| BaseSerializer.params_include?(params, 'sessions') }
  has_many :doctors, if: proc { |_record, params| BaseSerializer.params_include?(params, 'doctors') }
end
