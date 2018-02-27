class GoogleCalendarService

  def initialize(current_user)
    @current_user = current_user
  end

  def all_appointments
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    if current_user.calendar.nil?
      calendar = Google::Apis::CalendarV3::Calendar.new(
        summary: 'TherapyTrack'
      )
      service.insert_calendar(calendar)

      user_calendar = service.insert_calendar(calendar)

      current_user.update!(calendar: user_calendar.id)
    end
    service.list_events(current_user.calendar)
  end

  def create_appointment(event_info)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = user_auth
#check current_user.calendar.nil?
    today = Date.today
    event = Google::Apis::CalendarV3::Event.new({
      start: Google::Apis::CalendarV3::EventDateTime.new(date: today),
      end: Google::Apis::CalendarV3::EventDateTime.new(date: today + 1),
      summary: 'New event!'
    })
    service.insert_event(user.calendar, event)
  end

      private
        attr_reader :current_user, :client

        def client
          Signet::OAuth2::Client.new(user_auth)
        end

        def user_auth
          {
            "access_token"  => current_user.oauth_token,
            "expires_in"    => current_user.oauth_expires_at,
            "token_type"    => 'Bearer',
            "refresh_token" => current_user.refresh_token
          }
        end
end