require 'rails_helper'

feature 'A user can see an about page' do
  scenario 'as a logged in user' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/'
    click_on 'About'

    expect(current_path).to eq about_path
    expect(page).to have_content 'About TherapyTrack'
  end
end
