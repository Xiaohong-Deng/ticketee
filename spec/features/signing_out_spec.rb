require "rails_helper"

RSpec.feature "Signed-in users can sign out" do
  let(:user) { FactoryGirl.create(:user) }

  before do
    # method from Warden, a gem used by Devise
    # needs to be manully included in spec/rails_helper.rb
    login_as(user)
  end

  scenario do
    visit "/"
    click_link "Sign out"
    expect(page).to have_content "Signed out successfully."
  end
end
