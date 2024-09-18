class BaseSerializer
  include JSONAPI::Serializer

  def self.params_include?(params, key)
    params[:include]&.include?(key)
  end

  # cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 5.minutes
end
