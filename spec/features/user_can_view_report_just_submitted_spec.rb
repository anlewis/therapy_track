require 'rails_helper'

feature 'User can view their generated wellness report' do
  scenario 'as a logged in user with only medical report' do
    user = create(:user)
    report = create(:report, user: user)
    medical_report = create(:medical_report, report: report)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit report_submit_path(report.id)

    click_on 'Submit Report'

    expect(page).to have_content 'Wellness Report'
    expect(page).to have_content 'Basic Medical Information'
    expect(page).to have_content "O2 Saturation: #{medical_report.oxygen} %"
  end
end