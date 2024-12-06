class ApplicationMailer < ActionMailer::Base
  default from: ENV['ACTION_MAILER_EMAIL'] || 'vrapeutic-all.login-verification@myvrapeutic.com'
  layout 'mailer'
end
