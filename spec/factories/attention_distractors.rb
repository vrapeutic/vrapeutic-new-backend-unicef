FactoryBot.define do
  factory :attention_distractor do
    name { "MyString" }
    time_following_it_seconds { 1.5 }
    attention_performance { nil }
  end
end
