require 'rails_helper'

feature 'User can add a new appointment' do
  context 'as a valid user' do
    it 'they can create a new appointment' do
      VCR.use_cassette("features/new_appointment") do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        
        visit '/appointments'

        click_on 'Schedule New Appointment'

        expect(current_path).to eq '/appointments/new'

        fill_in 'appointment[summary]', with: 'Appointment'
        fill_in 'appointment[location]', with: '1234 St'
        fill_in 'appointment[description]', with: 'description'
        fill_in 'appointment[start]', with: '2015-05-28T09:00:00-07:00'
        fill_in 'appointment[end]', with: '2015-05-28T17:00:00-07:00'

        click_on 'Create Appointment'

        expect(Appointment.last.summary).to eq 'Appointment'

        expect(page).to have_content 'Appointment'
        expect(page).to have_content '1234 St'
        expect(page).to have_content 'description'
        expect(page).to have_content 'start'
        expect(page).to have_content 'end'
      end
    end
  end
end



# { summary: 'Google I/O 2015',
#   location: '800 Howard St., San Francisco, CA 94103',
#   description: 'A chance to hear more about Google\'s developer products.',
#   start: {
#     date_time: '2015-05-28T09:00:00-07:00',
#     time_zone: 'America/Los_Angeles',
#   },
#   end: {
#     date_time: '2015-05-28T17:00:00-07:00',
#     time_zone: 'America/Los_Angeles',
#   },
#   recurrence: [
#     'RRULE:FREQ=DAILY;COUNT=2'
#   ],
#   attendees: [
#     {email: 'lpage@example.com'},
#     {email: 'sbrin@example.com'},
#   ],
#   reminders: {
#     use_default: false,
#     overrides: [
#       {method' => 'email', 'minutes: 24 * 60},
#       {method' => 'popup', 'minutes: 10},
#     ],
#   },
# }