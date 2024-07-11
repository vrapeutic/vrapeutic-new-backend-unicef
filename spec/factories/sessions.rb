FactoryBot.define do
  factory :session do
    center { nil }
    headset { nil }
    child { nil }
    evaluation { 1 }
    duration { 1.5 }
    is_verified { false }
  end
end
