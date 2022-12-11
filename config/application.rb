require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ReservationApp02
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.i18n.default_locale = :ja #11/21 1305 日本語化のため記述を追記
    config.time_zone = 'Asia/Tokyo' #11/21 1315 created.atカラムを取り出した時に日本時間に変換するために記述
    Faker::Config.locale = :ja

  end
end
