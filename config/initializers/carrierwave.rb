# frozen_string_literal: true

if Rails.env.production?
    CarrierWave.configure do |config|
      config.storage    = :aws
      config.aws_bucket = Rails.application.credentials.aws_s3[:S3_BUCKET_NAME]
      config.aws_acl    = 'public-read'
      config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7
  
      config.aws_credentials = {
        access_key_id: Rails.application.credentials.aws_s3[:AWS_ACCESS_KEY_ID],
        secret_access_key: Rails.application.credentials.aws_s3[:AWS_SECRET_ACCESS_KEY],
        region: Rails.application.credentials.aws_s3[:AWS_REGION] # Required
      }
    end
  else
    CarrierWave.configure do |config|
      config.storage = :file
      config.enable_processing = false
    end
  end
  
  CarrierWave.configure do |config|
    config.asset_host = ActionController::Base.asset_host
  end
  
  # https://github.com/rack/rack/issues/1075
  # Rack::Multipart::Parser.const_set('BUFSIZE', 10_000_000)
  