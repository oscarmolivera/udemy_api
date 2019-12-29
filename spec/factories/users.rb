FactoryBot.define do
  factory :user do
    sequence(:login) { |l| "usuario#{l}@login.com" }
    name { "John Snow" }
    url { "http://mytestapp.com" }
    avatar_url { "http://mytestapp.com/avatar.gif" }
    provider { "github" }
  end
end
