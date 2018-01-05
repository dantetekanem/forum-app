class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username, :name])
  end

  private

  def require_admin
    redirect_to root_path, notice: 'Only admin access allowed.' unless current_user.admin?
  end

  def require_moderator
    redirect_to root_path, notice: 'Only moderator access allowed.' unless current_user.admin? || current_user.moderator?
  end
end
