require 'rails_helper'

describe GoogleCalendarService do
  describe "instance methods" do
    it "#create_appointment" do
        user = create(:user)
        stub_omniauth
        visit root_path
        click_link 'Sign In with Google'

        google_calendar_service = GoogleCalendarService.new(user)
        start_time = Time.zone.parse('2002-01-01 04:00:00 -0000')
        end_time = Time.zone.parse('2002-01-01 06:00:00 -0000')
        created_appointment = google_calendar_service
          .create_appointment('test appointment',
                              'here',
                              'about this appointment',
                              start_time,
                              end_time,
                             )
        expect(created_appointment.summary).to eq 'test appointment'
        expect(created_appointment.location).to eq 'here'
        expect(created_appointment.description).to eq 'about this appointment'
        expect(created_appointment.start.date_time).to eq start_time
        expect(created_appointment.end.date_time).to eq end_time
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