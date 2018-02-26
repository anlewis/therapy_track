class GoogleCalendarService

  def initialize(current_user)
    @current_user = current_user
  end

  def all_appointments
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = authorization
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

  def new_appointment(event_info)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = authorization
    if current_user.calendar.nil?
      calendar = Google::Apis::CalendarV3::Calendar.new(
        summary: 'TherapyTrack'
      )
      service.insert_calendar(calendar)

      user_calendar = service.insert_calendar(calendar)

      current_user.update!(calendar: user_calendar.id)
    end
    today = Date.today
    event = Google::Apis::CalendarV3::Event.new({
      start: Google::Apis::CalendarV3::EventDateTime.new(date: today),
      end: Google::Apis::CalendarV3::EventDateTime.new(date: today + 1),
      summary: 'New event!'
    })
    service.insert_event(user.calendar, event)
  end

      private
        attr_reader :current_user

        def authorization
          {
            access_token:   current_user.google_auth.access_token,
            expires_in:     current_user.google_auth.expires_in,
            token_type:     current_user.google_auth.token_type,
            refresh_token:  current_user.google_auth.refresh_token
          }
        end
end