class SessionSerializer
  include JSONAPI::Serializer
  attributes :center_id, :headset_id, :child_id, :duration, :evaluation, :is_verified, :ended_at, :session_id, :note, :evaluation_file_url,
             :created_at, :updated_at

  has_many :software_modules, if: proc { |_record, params| BaseSerializer.params_include?(params, 'software_modules') }
  has_many :doctors, if: proc { |_record, params| BaseSerializer.params_include?(params, 'doctors') }
end
