class GoogleOauthController < ApplicationController
  def redirect
    client = Signet::OAuth2::Client.new(client_options)
    redirect_to client.authorization_uri.to_s
  end

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(code: params[:code])
    response = client.fetch_access_token!

    session[:authorization] = response

    auth = GoogleAuth.create(access_token:  response["access_token"],
                             expires_in:    response["expires_in"],
                             token_type:    response["token_type"],
                             refresh_token: response["refresh_token"]
    )

    current_user.google_auth = auth

    redirect_to root_path
  end

  private
    def client_options
      {
        client_id: ENV['google_client_id'],
        client_secret: ENV['google_client_secret'],
        authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
        redirect_uri: google_oauth_callback_url,
      }
    end
end
