class Admin::ApplicationController < ApplicationController
  before_action :authorize_admin!
  skip_after_action :verify_authorized, :verify_policy_scoped

  def index
  end

  private
    def authorize_admin!
      # provided by Devise, ensure user is logged in
      # otherwise redirect to sign in page
      authenticate_user!

      unless current_user.admin?
        redirect_to root_path, alert: "You must be an admin to do that."
      end
    end
end
