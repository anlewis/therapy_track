class AppointmentsController < ApplicationController
  def index
    @appointments = GoogleCalendarService.new(current_user).all_appointments
  end

  def new
  end

  def create
    GoogleCalendarService.new(current_user).create_appointment(
      params['summary'],
      params['location'],
      params['description'],
      Time.zone.parse(params['start']),
      Time.zone.parse(params['end'])
    )
    redirect_to appointments_url(calendar_id: current_user.calendar)
  end

  def edit
  end

  def update
    GoogleCalendarService.new(current_user).update_appointment(
      params['id'],
      params['summary'],
      params['location'],
      params['description'],
      Time.zone.parse(params['start']),
      Time.zone.parse(params['end'])
    )
    redirect_to appointments_url(calendar_id: current_user.calendar)
  end
end
