require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EveryLeafApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.generators do |g|
      g.test_framework :rspec,
        model_spec: true,
        view_spec: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
    end
  end
end
