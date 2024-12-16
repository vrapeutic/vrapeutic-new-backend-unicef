class Rack::Attack
  throttle('sign_in_limit', limit: 1, period: 5.seconds) do |request|
    request.ip if request.path.include?('sign_in') && request.post?
  end
  throttle('send_otp_limit', limit: 1, period: 5.seconds) do |request|
    request.ip if request.path.include?('send_otp') && request.post?
  end
  throttle('resend_otp_limit', limit: 1, period: 5.seconds) do |request|
    request.ip if request.path.include?('resend_otp') && request.post?
  end
  throttle('forget_password_limit', limit: 1, period: 5.seconds) do |request|
    request.ip if request.path.include?('forget_password') && request.get?
    request.ip if request.path.include?('invite_doctor') && request.post?
  end
  throttle('invite_doctor_limit', limit: 1, period: 5.seconds) do |request|
    request.ip if request.path.include?('invite_doctor') && request.post?
  end
end
