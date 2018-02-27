class AppointmentsController < ApplicationController
  def index
    @appointments = GoogleCalendarService.new(current_user).all_appointments
  end

  def create
    GoogleCalendarService.new(current_user).create_appointment(event_info)
    redirect_to appointments_url(calendar_id: current_user.calendar)
  end

  def new
  end
end
