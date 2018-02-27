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

  def create_appointment(summary, location, description, start, finish)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
#check current_user.calendar.nil?
    event = Google::Apis::CalendarV3::Event.new({
      summary: summary,
      location: location,
      description: description,
      start: Google::Apis::CalendarV3::EventDateTime.new(date: start),
      end: Google::Apis::CalendarV3::EventDateTime.new(date: finish),
    })
    service.insert_event(current_user.calendar, event)
  end

      private
        attr_reader :current_user, :client, :event_info

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

        def info 
          {
            summary: params['summary'],
            location: params['location'],
            description: params['description'],
            start: params['start'],
            end: params['end']
          }
        end
end