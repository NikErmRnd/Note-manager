class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, {:roles => []}, :avatar, :provider, :uid)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, {:roles => []}, :avatar, :provider, :uid)
  end
end