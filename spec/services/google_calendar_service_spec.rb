require 'rails_helper'

describe GoogleCalendarService do
  describe "instance methods" do
    before(:each) do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    it "#all_appointments" do
    end
    it "#create_appointment" do
    end
    it "#update_appointment" do
    end
    it "#delete_appointment" do
    end
  end
end