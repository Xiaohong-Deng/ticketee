require "rails_helper"

RSpec.feature 'Users can view tickets' do
  before do
    author = FactoryGirl.create(:user)
    login_as(author)

    sublime = FactoryGirl.create(:project, name: "Sublime Text 3")
    FactoryGirl.create(:ticket, project: sublime, author: author,
      name: "Make it shiny!",
      description: "Gardients! Starbursts! Oh my!")
    assign_role!(author, :viewer, sublime)

    ie = FactoryGirl.create(:project, name: "Internet Explorer")
    FactoryGirl.create(:ticket, project: ie, author: author,
      name: "Standards compliance",
      description: "Isn't a joke.")
    assign_role!(author, :viewer, ie)

    visit "/"
  end

  scenario "for a given project" do
    click_link "Sublime Text 3"

    expect(page).to have_content "Make it shiny!"
    expect(page).to_not have_content "Standards compliance"

    click_link "Make it shiny!"
    within("#ticket h2") do
      expect(page).to have_content "Make it shiny!"
    end
    expect(page).to have_content "Gardients! Starbursts! Oh my!"
  end
end
