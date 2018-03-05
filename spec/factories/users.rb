FactoryBot.define do
  factory :user do
    provider ENV['provider']
    uid ENV['uid']
    name ENV['name']
    oauth_token ENV['oauth_token']
    oauth_expires_at ENV['oauth_expires_at']
    refresh_token ENV['refresh_token']
    calendar ENV['calendar']
  end
end
