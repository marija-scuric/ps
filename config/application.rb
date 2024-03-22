# typed: false
# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PS
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults(7.0)

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Use canonical logging
    # https://github.com/Shopify/shopify-cloud/blob/main/guides/logging.md#basics
    config.shopify_cloud.logging.use_canonical_logging = true

    # Disable Raindrops middleware (because we spawn a monitor thread instead, see config/puma.rb).
    # https://github.com/shopify/shopify_metrics#spawn-raindrops-monitor-thread
    config.x.shopify_metrics_disable_raindrops_middleware = true

    config.generators.after_generate do |files|
      parsable_files = files.filter { |file| file.end_with?(".rb") }
      system("bundle exec rubocop -A --fail-level=E #{parsable_files.shelljoin}", exception: true)
    end
  end
end
