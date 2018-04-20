require 'rails_helper'

describe GoogleCalendarService do
  describe "instance methods" do
    it "#create_appointment" do
        user = create(:user)
        binding.pry
        stub_omniauth
        binding.pry
        visit root_path
        click_link 'Sign In with Google'
        save_and_open_page
        google_calendar_service = GoogleCalendarService.new(user)
        created_appointment = google_calendar_service
         .create_appointment('test appointment',
                            'here',
                            'about this appointment',
                            Time.zone.parse('2002-01-01 04:00:00 -0000'),
                            Time.zone.parse('2002-01-01 06:00:00 -0000')
                           )
        expect(created_appointment).to contain('test appointment')\
    end
    it "#all_appointments" do
      #recieve a list of all appointments
    end
    it "#update_appointment" do
    end
    it "#delete_appointment" do
    end
  end

  private
    attr_reader :current_user, :client, :event_info

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
        scope: 'email,profile,calendar',
        provider_ignores_state: true,
        additional_parameters: {"access_type" => "offline"}
      }
    end

    def info
      {
        summary: params['summary'],
        location: params['location'],
        description: params['description'],
        start: params['start'],
        end: params['end'],
        additional_parameters: {"access_type" => "offline",         # offline access
                                "include_granted_scopes" => "true"  # incremental auth
                               }
      }
    end
end