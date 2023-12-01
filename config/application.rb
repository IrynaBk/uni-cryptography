require_relative "boot"

require "rails/all"
require 'dotenv/rails-now'


require "openssl"
Dotenv::Railtie.load

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CryptographyProject
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.python_modules = config_for(:python_modules)
    # config/application.rb
    config.autoload_paths += %W(#{config.root}/app/services)


    config.before_configuration do
      is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin|msys|mingw|cygwin|bccwin|wince|emc/)
      ENV['PYTHON_COMMAND'] = is_windows ? 'python' : 'python3'
    end
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
