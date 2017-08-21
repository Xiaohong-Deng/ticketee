require "rails_helper"

RSpec.feature 'Users can sign up' do
  scenario 'when providing valid information' do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: "test@example.com"
    # Capybara lets you select by id or name attr
    fill_in "user_password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    expect(page).to have_content "You have signed up successfully."
  end
end
