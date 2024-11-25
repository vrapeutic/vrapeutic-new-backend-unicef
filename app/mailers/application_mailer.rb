class ApplicationMailer < ActionMailer::Base
  default from: ENV['ACTION_MAILER_EMAIL'] || 'ahmed.abdelhamid@myvrapeutic.com'
  layout 'mailer'
end
