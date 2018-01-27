require "rails_helper"

RSpec.feature "Users can view a ticket's attached files" do
  let(:user) { FactoryBot.create :user }
  let(:project) { FactoryBot.create :project }
  let(:ticket) { FactoryBot.create :ticket, project: project,
    author: user }
  let!(:attachment) { FactoryBot.create :attachment, ticket: ticket,
    file_to_attach: "spec/fixtures/speed.txt" }

  before do
    assign_role!(user, :viewer, project)
    login_as(user)
  end

  scenario 'successfully' do
    visit project_ticket_path(project, ticket)
    click_link "speed.txt"

    expect(current_path).to eq attachment_path(attachment)
    expect(page).to have_content "I refuse to say anything about speed."
  end
end
