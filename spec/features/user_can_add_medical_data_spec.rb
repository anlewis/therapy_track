require 'rails_helper'

feature 'A user can add basic medical info for their report' do
  scenario 'as a logged in user' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/'
    click_on 'Generate New Wellness Report'

    page.fill_in 'medical_report[oxygen]', with: 96
    page.fill_in 'medical_report[temperature]', with: 98
    page.fill_in 'medical_report[systolic]',    with: 90
    page.fill_in 'medical_report[diastolic]',   with: 130
    page.fill_in 'medical_report[weight]',      with: 120
    page.fill_in 'medical_report[notes]',       with: 'Notes about appointment.'

    click_on 'Add Medical Info'
    medical_info = MedicalReport.last

    expect(medical_info.oxygen).to eq 96
    expect(medical_info.temperature).to       eq 98
    expect(medical_info.systolic).to          eq 90
    expect(medical_info.diastolic).to         eq 130
    expect(medical_info.weight).to            eq 120
    expect(medical_info.notes).to             eq 'Notes about appointment.'
  end
end
