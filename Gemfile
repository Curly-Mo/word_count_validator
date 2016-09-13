source "https://rubygems.org"
ruby "2.3.1"

gem "sinatra"
gem "sinatra-contrib"

gem "json"
gem "rack"

group :test, :development do
  gem "rspec"
  gem 'coveralls', require: false
  gem "extlib_lite"
end

group :production do
  gem 'puma'
end

gem "literate_randomizer"
gem "json-schema"
