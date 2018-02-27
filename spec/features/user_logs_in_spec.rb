require 'rails_helper'

feature "user logs in" do
  scenario "using google oauth2" do
    create(:user)
    stub_omniauth
    visit root_path
    
    expect(page).to have_link("Sign In with Google")
    click_link "Sign In with Google"

    expect(page).to have_content("Anna Lewis")
    expect(page).to have_link("Sign Out")
  end
end