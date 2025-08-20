class AuthController < ApplicationController
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys:[:email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys:[:phone, :username])
  end

  private

  def user_not_authorized
    flash[:alert] = "Vous n'êtes pas autoriser à éffectuer cette action."
    redirect_to(request.referrer || root_path)
  end

  def pundit_user
    current_user
  end
end
