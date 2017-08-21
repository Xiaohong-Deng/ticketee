require "rails_helper"

RSpec.feature 'Users can delete tickets' do
  let(:project) { FactoryGirl.create(:project) }
  let(:author) { FactoryGirl.create(:user) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, author: author) }

  before do
    login_as(author)
    # in a single scenario calling project 10 time won't create
    # 10 records in Project table, just 1
    assign_role!(author, :manager, project)
    visit project_ticket_path(project, ticket)
  end

  scenario 'successfully' do
     click_link "Delete Ticket"

     expect(page).to have_content "Ticket has been deleted."
     expect(page.current_url).to eq project_url(project)
  end
end
