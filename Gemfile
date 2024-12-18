source "https://rubygems.org"

ruby "3.2.2"

gem "rails", "~> 7.1.5", ">= 7.1.5.1"

gem "sprockets-rails"

gem "pg", "~> 1.1"

gem "puma", ">= 5.0"

gem "importmap-rails"

gem "turbo-rails"

gem "stimulus-rails"

gem "tailwindcss-rails"

gem "jbuilder"


# Authentication
gem 'devise'
gem 'jwt'

# Other useful gems
gem 'friendly_id'
gem 'kaminari'  # Pagination
gem 'searchkick'  # Search functionality
gem 'image_processing'  # For image processing
gem 'active_storage_validations'
gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "bootsnap", require: false


group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  gem "web-console"

end
gem 'faker'
group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
