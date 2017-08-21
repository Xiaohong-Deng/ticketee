require 'rails_helper'

RSpec.describe Admin::ApplicationController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  before do
    # return nil on authenticate_user! call
    allow(controller).to receive(:authenticate_user!)
    # controller here is an instance of Admin::ApplicationController
    # which will be used in this test. allow method make this instance
    # respond to method call of "current_user" with user call defined
    # above, not the real current_user method defined in the controller
    allow(controller).to receive(:current_user).and_return(user)
    # but where do we get to call the current_user method in the test?
  end

  context "non-admin users" do
    it "are not able to access the index action" do
      # current_user gets called here, inside application#index
      # also authenticate_user!
      get :index

      expect(response).to redirect_to "/"
      expect(flash[:alert]).to eq "You must be an admin to do that."
    end
  end

end
