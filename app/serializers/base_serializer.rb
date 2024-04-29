class BaseSerializer
  include JSONAPI::Serializer

  def self.params_include?(params, key)
    params[:include]&.include?(key)
  end
end
