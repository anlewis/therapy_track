class AppointmentsController < ApplicationController
  def index
    auth = session[:authorization]
    @appointments = GoogleCalendarService.new(auth, current_user).all_appointments


    # client = Signet::OAuth2::Client.new(client_options)
    # client.update!(session[:authorization])

    # service = Google::Apis::CalendarV3::CalendarService.new
    # service.authorization = client

    # create_appointments_calendar(client)
    # @event_list = service.list_events(current_user.calendar)
    
    # # protect from expired access token errors
    # rescue Google::Apis::AuthorizationError
    # response = client.refresh!

    # session[:authorization] = session[:authorization].merge(response)

    # retry
  end

  def create
    auth = session[:authorization]
    GoogleCalendarService.new(auth, current_user).new_appointment(event_info)
    redirect_to appointments_url(calendar_id: current_user.calendar)
  end

  def new
    # @appointment = Appointment.new
  end

  private
    # def client_options
    #   {
    #     client_id: ENV['google_client_id'],
    #     client_secret: ENV['google_client_secret'],
    #     authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
    #     token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
    #     scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
    #     redirect_uri: google_oauth_callback_url
    #   }
    # end

    # def create_appointments_calendar(client)
    #   # create calendar for user if necessary
    #   if current_user.calendar.nil?
    #     service = Google::Apis::CalendarV3::CalendarService.new
    #     service.authorization = client

    #     calendar = Google::Apis::CalendarV3::Calendar.new(
    #       summary: 'TherapyTrack'
    #     )
    #     service.insert_calendar(calendar)

    #     user_calendar = service.insert_calendar(calendar)

    #     current_user.update!(calendar: user_calendar.id)
    #   end
    # end
end
