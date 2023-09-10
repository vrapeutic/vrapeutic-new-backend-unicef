class SessionSerializer
  include JSONAPI::Serializer
  attributes :center_id, :headset_id, :child_id, :duration, :evaluation, :is_verified
end
