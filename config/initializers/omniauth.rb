OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "797020357105836", "3d8afb5470d518e78b9e601e3203667b"
end