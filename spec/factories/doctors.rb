FactoryBot.define do
  factory :doctor do
    name { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
    degree { "MyString" }
    university { "MyString" }
    is_email_verified { false }
  end
end
