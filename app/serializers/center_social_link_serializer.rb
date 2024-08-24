class CenterSocialLinkSerializer < BaseSerializer
  attributes :link, :link_type, :center_id, :created_at, :updated_at

  has_one :center, if: proc { |_record, params| BaseSerializer.params_include?(params, 'center') }
end
