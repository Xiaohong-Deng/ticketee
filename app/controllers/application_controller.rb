class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized
  after_action :verify_policy_scoped, only: [:index], unless: :devise_controller?
  after_action :verify_authorized, except: [:index], unless: :devise_controller?

  private
    def not_authorized
      redirect_to root_path, alert: "You aren't allowed to do that."
    end
end
