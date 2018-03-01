FactoryBot.define do
  factory :user do
    provider 'google_oauth2'
    uid ENV['uid']
    name 'Anna Lewis'
    oauth_token ENV['oauth_token']
    oauth_expires_at '018-02-27 15:35:40 -0700'
    refresh_token ENV['refresh_token']
    calendar ENV['calendar']
  end
end
