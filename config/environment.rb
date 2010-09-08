# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

ENV['GEM_PATH']='/usr/lib/ruby/gems/1.8'

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

# Used for debugging, offset the time to October 15, 2009 by subtracting the # of seconds
# from the current time. This should be in GMT time.
# year * month * day * hour * minute * second
TIME = Time.now.utc

# A blank string means times will be displayed in ET
if TIME.dst?
  TIMEZONE = "-05:00"
else
  TIMEZONE = "-04:00"
end

PUBLISHER_ID = "1"

BOOKMAKER_ID = 6

FEEDFETCHER_ARCHIVE = "/home/sportbookpage/FeedFetcherDeluxe/archive/"

PROFILE_KEYS =
          ["birthday",
           "hometown",
           "favorite_coach",
           "jersey_number",
           "favorite_team",
           "favorite_athlete",
           "favorite_sport",
           "about_me",
           "popupHelp"]

SPORTS =
    ["Basketball",
    "Baseball",
    "Ice Hockey",
    "American Football"]


PROFESSIONAL_LEAGUES =
            ["National Basketball Association",
            "National Hockey League",
            "National Football League",
            "Major League Baseball"]


COLLEGE_LEAGUES = ["NCAA Men's Basketball Division 1",
				   "NCAA Men's Football Division 1A",
				   "NCAA Men's Football Division 1AA",
				   "NCAA Men's Football Division 2",
				   #"NCAA Men's Football Division 3",
				   "NCAA Men's Baseball",
				   "NCAA Women's Basketball Division 1"]

ALL_LEAGUES = ["National Basketball Association",
            "National Hockey League",
            "National Football League",
            "Major League Baseball",
			"NCAA Men's Basketball Division 1",
			"NCAA Men's Football Division 1A",
			"NCAA Men's Football Division 1AA",
			"NCAA Men's Football Division 2",
			#"NCAA Men's Football Division 3",
			"NCAA Men's Baseball",
			"NCAA Women's Basketball Division 1"]


STANDINGS_SCOPE = {"National Basketball Association" => "all",
            "National Hockey League" => "league",
            "National Football League" => "all",
            "Major League Baseball" => "all",
            "NCAA Men's Basketball Division 1" => "league",
            "NCAA Men's Football Division 1A" => "league",
            "NCAA Men's Football Division 1AA" => "league",
            "NCAA Men's Football Division 2" => "league",
			#"NCAA Men's Football Division 3" => "league",
			"NCAA Men's Baseball" => "league",
			"NCAA Women's Basketball Division 1" => "league"}


Rails::Initializer.run do |config|
  


  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de

  # Set to one of [:active_record_store, :drb_store, :mem_cache_store, :cookie_store]
  config.action_controller.session_store = :active_record_store


  config.action_mailer.delivery_method = :smtp

  # these options are only needed if you choose smtp delivery
  #config.action_mailer.smtp_settings = {
  #  :address        => 'smtp.gmail.com',
  #  :port           => 578,
  #  :domain         => 'www.sportbookpage.com',
  #  :authentication => :login,
  #  :user_name      => 'NathanALadd@gmail.com',
  #  :password       => '$bp.com'
  #}

  #ActionMailer::Base.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address => "localhost",
    :port => 25,
    :domain => "www.sportbookpage.com",
  }

end





