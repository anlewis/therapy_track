require 'rails_helper'

describe GoogleCalendarService do
  describe "instance methods" do
    it "#create_appointment" do
      VCR.use_cassette 'features/google_calendar_service/create_appointment' do
        user = create(:user)
        stub_omniauth
        visit root_path
        click_link 'Sign In with Google'

        google_calendar_service = GoogleCalendarService.new(user)
        start_time = Time.zone.parse('2002-01-01 04:00:00 -0000')
        end_time = Time.zone.parse('2002-01-01 06:00:00 -0000')
        created_appointment = google_calendar_service
          .create_appointment('test appointment',
                              'here',
                              'about this appointment',
                              start_time,
                              end_time,
                             )
        expect(created_appointment.summary).to eq 'test appointment'
        expect(created_appointment.location).to eq 'here'
        expect(created_appointment.description).to eq 'about this appointment'
        expect(created_appointment.start.date_time).to eq start_time
        expect(created_appointment.end.date_time).to eq end_time
      end
    end

    it "#all_appointments" do
      VCR.use_cassette 'features/google_calendar_service/all_appointments' do
        user = create(:user)
        stub_omniauth
        visit root_path
        click_link 'Sign In with Google'

        google_calendar_service = GoogleCalendarService.new(user)
        start_time_1 = Time.zone.parse('2002-01-01 04:00:00 -0000')
        end_time_1 = Time.zone.parse('2002-01-01 06:00:00 -0000')
        appointment_1 = google_calendar_service
          .create_appointment('test appointment 1',
                              'here',
                              'about this appointment',
                              start_time_1,
                              end_time_1,
                             )
        start_time_2 = Time.zone.parse('2002-01-01 06:00:00 -0000')
        end_time_2 = Time.zone.parse('2002-01-01 08:00:00 -0000')
        appointment_2 = google_calendar_service
          .create_appointment('test appointment 2',
                              'here',
                              'about this appointment',
                              start_time_2,
                              end_time_2,
                             )
        appointments = google_calendar_service.all_appointments.items

        expect(appointments[-1].summary).to eq appointment_2.summary
        expect(appointments[-2].summary).to eq appointment_1.summary
      end
    end

    it "#update_appointment" do
      VCR.use_cassette 'features/google_calendar_service/update_appointment' do
        user = create(:user)
        stub_omniauth
        visit root_path
        click_link 'Sign In with Google'

        google_calendar_service = GoogleCalendarService.new(user)
        start_time = Time.zone.parse('2002-01-01 04:00:00 -0000')
        end_time = Time.zone.parse('2002-01-01 06:00:00 -0000')
        created_appointment = google_calendar_service
          .create_appointment('test appointment',
                              'here',
                              'about this appointment',
                              start_time,
                              end_time,
                             )
        google_calendar_service.update_appointment(created_appointment.id,
                                                    'updated test appointment',
                                                    'there',
                                                    'other stuff about this appointment',
                                                    start_time,
                                                    end_time)
        updated_appointment = google_calendar_service.all_appointments.items.last

        expect(updated_appointment.summary).to eq 'updated test appointment'
        expect(updated_appointment.location).to eq 'there'
        expect(updated_appointment.description).to eq 'other stuff about this appointment'
      end
    end

    it "#delete_appointment" do
      VCR.use_cassette 'features/google_calendar_service/delete_appointment' do
        user = create(:user)
        stub_omniauth
        visit root_path
        click_link 'Sign In with Google'

        google_calendar_service = GoogleCalendarService.new(user)
        start_time = Time.zone.parse('2002-01-01 04:00:00 -0000')
        end_time = Time.zone.parse('2002-01-01 06:00:00 -0000')
        created_appointment = google_calendar_service
          .create_appointment('delete this appointment',
                              'here',
                              'about this appointment',
                              start_time,
                              end_time,
                             )
        expect(created_appointment.summary).to eq google_calendar_service.all_appointments.items.last.summary

        google_calendar_service.delete_appointment(created_appointment.id)

        expect(created_appointment.summary).not_to eq google_calendar_service.all_appointments.items.last.summary
      end
    end
  end
end