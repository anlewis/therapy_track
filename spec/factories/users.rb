FactoryBot.define do
  factory :user do
    provider "MyString"
    uid ENV['uid']
    name "Anna Lewis"
    oauth_token ENV['oauth_token']
    oauth_expires_at "2018-02-17 11:59:30"
    role 0
    calendar ENV['calendar']
  end
end