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

  def refresh_token_if_expired
    if token_expired?
    
      token_will_change!
      expiresat_will_change!

      self.oauth_token     = refresh_hash['access_token']
      self.oauth_expires_at = refresh_hash["expires_at"]

      self.save
      puts 'Saved'
    end
  end

  def token_expired? 
    return true if self.oauth_expires_at < Time.now # expired token, so we should quickly return
    token_expires_at = self.oauth_expires_at
    save if changed?
    false # token not expired
  end

  private
    def client
      Signet::OAuth2::Client.new(user_auth)
    end

    def user_auth
      {
        'client_id'     => ENV['google_client_id'],
        'client_secret' => ENV['google_client_secret'],
        'access_token'  => current_user.oauth_token,
        'expires_in'    => current_user.oauth_expires_at,
        'token_type'    => 'Bearer',
        'refresh_token' => current_user.refresh_token,
      }
    end
end
