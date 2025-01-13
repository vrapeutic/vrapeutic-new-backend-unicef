class HeadsetSerializer < BaseSerializer
  attributes :model, :key, :center, :center_id, :discarded_at, :created_at, :updated_at

  has_one :center, if: proc { |_record, params| BaseSerializer.params_include?(params, 'center') }
  has_many :sessions, if: proc { |_record, params| BaseSerializer.params_include?(params, 'sessions') }
end
