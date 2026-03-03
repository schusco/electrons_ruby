class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :check_for_admin_login

  private
  def check_for_admin_login
    secret = Rails.application.credentials.admin_token.to_s
    if params[:login].to_s == secret
      session[:admin_token] = secret
      redirect_to roster_path, notice: "Admin login successful"
    elsif params[:logout].to_s == "true"
      session.delete(:admin_token)
      redirect_to roster_path, notice: "Admin logout successful"
    end
  end
  def authenticate_admin!
      unless params[:admin_token] == Rails.application.credentials.admin_token.to_s || admin?
        redirect_to root_path, alert: "Unauthorized access"
      end
  end
  def admin?
    session[:admin_token].to_s == Rails.application.credentials.admin_token.to_s
  end
  helper_method :admin?
end
