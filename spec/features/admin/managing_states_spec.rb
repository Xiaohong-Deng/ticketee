require "rails_helper"

RSpec.feature 'Admins can manage states' do
  let!(:state) { FactoryGirl.create :state, name: "New" }

  before do
    login_as(FactoryGirl.create(:user, :admin))
    visit admin_states_path
  end

  scenario 'and mark a state as default' do
    # list_item is a custom method which returns css selectors or html elements
    # object returned is Capybara::Node::Element, it is unique w.r.t the text content
    # within method raises exception when encounters element being found in multiple
    # places on the page
    within list_item("New") do
      click_link "Make Default"
    end

    expect(page).to have_content("'New' is now the default state.")
  end
end
