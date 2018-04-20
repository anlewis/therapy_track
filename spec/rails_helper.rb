require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'support/factory_bot'
require 'coveralls'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.allow_http_connections_when_no_cassette = true
  config.hook_into :webmock
  config.filter_sensitive_data ('<fakeGoogleClientId>') { ENV['google_client_id'] }
  config.filter_sensitive_data ('<fakeGoogleClientSecret>') { ENV['google_client_secret'] }
  config.filter_sensitive_data ('<fakeGoogleClient>') { ENV['google_client'] }
  config.filter_sensitive_data ('<fakeCoverallsRepoToken>') { ENV['coveralls_repo_token'] }
  config.filter_sensitive_data ('<fakeOauthToken>') { ENV['oauth_token'] }
end

Coveralls.wear!('rails')

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

def stub_omniauth
  # set OmniAuth to run in test mode
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
    'provider' => 'google_oauth2',
    'uid' => ENV['uid'],
    'info' => {
      'name' => 'Anna Lewis',
      'email' => 'anna.noel.lewis@gmail.com',
      'first_name' => 'Anna',
      'last_name' => 'Lewis',
      'image' => 'https://lh6.googleusercontent.com/-V7qtjsjLs6o/AAAAAAAAAAI/AAAAAAAAAAk/HuQ6ZImHSPU/photo.jpg'
    },
    'credentials' => {
      'refresh_token' => ENV['refresh_token'],
      'token' => ENV['oauth_token'],
      'expires_at' => 1_519_532_155,
      'expires' => true
    }
  )
end
