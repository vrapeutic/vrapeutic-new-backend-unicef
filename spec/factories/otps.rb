FactoryBot.define do
  factory :otp do
    doctor { nil }
    code { "MyString" }
    expires_at { "2023-08-21 20:47:48" }
  end
end
