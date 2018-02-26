class AppointmentsController < ApplicationController
  def index
    @appointments = GoogleCalendarService.new(current_user).all_appointments
  end

  def create
    auth = session[:authorization]
    GoogleCalendarService.new(auth, current_user).new_appointment(event_info)
    redirect_to appointments_url(calendar_id: current_user.calendar)
  end

  def new
    # @appointment = Appointment.new
  end
end
