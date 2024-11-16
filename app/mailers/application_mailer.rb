class ApplicationMailer < ActionMailer::Base
  default from: ENV['ACTION_MAILER_EMAIL'] || 'vrapeutic@gmail.com'
  layout 'mailer'
end
