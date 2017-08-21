require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  it "handles a missing project correctly" do
    get :show, id: "not-there"

    expect(response).to redirect_to(projects_path)
    message = "The project you were looking for could not be found."
    expect(flash[:alert]).to eq message
  end

  it 'handles permission errors by redirecting' do
    # the point of stubbing out current_user is
    # we don't log in and if anything goes wrong with
    # log in feature we hope it doesn't affect our testing
    # this functionality
    # pundit will call current_user inside controller
    # allow method allows you to fake method responses
    # on that object
    allow(controller).to receive(:current_user)

    project = FactoryGirl.create(:project)
    # current_user returns nil, show? returns false
    # NotAuthorizedError raised
    get :show, id: project

    expect(response).to redirect_to(root_path)
    message = "You aren't allowed to do that."
    expect(flash[:alert]).to eq message
  end
end
