require 'google/api_client/client_secrets'

class User < ActiveRecord::Base
  has_one :google_auth
  has_many :reports

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.refresh_token = auth.credentials.refresh_token
      user.save!
    end
  end

  def refresh_token_if_expired(client)
    if self.oauth_expires_at < Time.now
      # binding.pry
      refresh_hash = client.refresh!

      self.oauth_token = refresh_hash['access_token']
      self.oauth_expires_at = Time.now + refresh_hash['expires_in']

      self.save
    end
    client
  end
end
