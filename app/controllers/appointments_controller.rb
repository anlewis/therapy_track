class AppointmentsController < ApplicationController
  def index
    @appointments = GoogleCalendarService.new(current_user).all_appointments
  end

  def create
    GoogleCalendarService.new(current_user).create_appointment(
      params['summary'],
      params['location'],
      params['description'],
      params['start'],
      params['end']
    )
    redirect_to appointments_url(calendar_id: current_user.calendar)
  end

  def new
  end
end
