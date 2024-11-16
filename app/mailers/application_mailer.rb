class ApplicationMailer < ActionMailer::Base
  default from: ENV['SENDER_MAILER_EMAIL']
  layout 'mailer'
end
