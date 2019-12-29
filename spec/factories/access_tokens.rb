FactoryBot.define do
  factory :access_token do
    sequence(:token) { |t| "MyString#{t}" }
    association :user
  end
end

