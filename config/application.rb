require_relative 'boot'

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Notedata
  class Application < Rails::Application
    config.i18n.default_locale = :ru
    config.i18n.locale = :ru
    # ENV['SSL_CERT_FILE']="C:/RailsInstaller/cacert.pem"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
