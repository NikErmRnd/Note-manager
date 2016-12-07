class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource_or_scope)
    current_user.sign_in_count >= 1 ? "/home/index" : "#{current_user.roles}"
  end

  def check_if_admin
     render text: "Access denied, you is not admin's right", status: 403 unless (current_user.roles=="admin")
    # render_403 unless params[:admin]
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit({ roles: [] }, :email, :password, :password_confirmation, :username) }
  end

end

