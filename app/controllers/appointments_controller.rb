class AppointmentsController < ApplicationController
  def index
    @appointments = GoogleCalendarService.new(current_user).all_appointments
  end

  def create
    GoogleCalendarService.new(current_user).create_appointment(
      params['summary'],
      params['location'],
      params['description'],
      params['start'].to_datetime.change(offset: "-0600"),
      params['end'].to_datetime.change(offset: "-0600")
    )
    redirect_to appointments_url(calendar_id: current_user.calendar)
  end

  def new
  end

  def update
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    event = service.get_event(current_user.calendar, params[:id])

    event.summary = params['summary']
    event.location = params['location']
    event.description = params['description']
    event.start = { date_time: params[:start].to_datetime }
    event.end = { date_time: params[:end].to_datetime }

    service.update_event(current_user.calendar, event.id, event)

    redirect_to appointments_url(calendar_id: current_user.calendar)
  end

  def edit
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    @event = service.get_event(current_user.calendar, params[:id])
  end

  private
    attr_reader :client

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
