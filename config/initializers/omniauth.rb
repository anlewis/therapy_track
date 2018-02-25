OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['google_client_id'], ENV['google_client_secret'],
    {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end


# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {
#     :name => "google",
#     :scope => ['contacts','plus.login','plus.me','email','profile'],
#     :prompt => "select_account",
#     :image_aspect_ratio => "square",
#     :image_size => 50,
#     :access_type => 'offline'
#   }
# end