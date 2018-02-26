class GoogleCalendarService

  def initialize(auth, current_user)
    @auth = auth
    @current_user = current_user
  end

  def all_appointments
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = auth
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
    service.authorization = auth
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
    service.insert_event(current_user.calendar, event)
  end

  private
    def create_appointments_calendar(auth, service)
      # create calendar for user if necessary
      if current_user.calendar.nil?
        calendar = Google::Apis::CalendarV3::Calendar.new(
          summary: 'TherapyTrack'
        )
        service.insert_calendar(calendar)

        user_calendar = service.insert_calendar(calendar)

        current_user.update!(calendar: user_calendar.id)
      end
    end

      private
        attr_reader :auth, :current_user
end