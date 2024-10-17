class SessionSerializer < BaseSerializer
  attributes :center_id, :headset_id, :child_id, :duration, :evaluation, :is_verified, :ended_at,
             :session_id, :note, :evaluation_file_url, :created_at, :updated_at

  has_one :center, if: proc { |_record, params| BaseSerializer.params_include?(params, 'center') }
  has_one :child, if: proc { |_record, params| BaseSerializer.params_include?(params, 'child') }
  has_one :headset, if: proc { |_record, params| BaseSerializer.params_include?(params, 'headset') }
  has_many :software_modules, if: proc { |_record, params| BaseSerializer.params_include?(params, 'software_modules') }
  has_many :doctors, if: proc { |_record, params| BaseSerializer.params_include?(params, 'doctors') }
end
