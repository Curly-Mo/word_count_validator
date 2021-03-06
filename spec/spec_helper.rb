ENV['RACK_ENV'] = 'test'

require File.expand_path '../../app', __FILE__
require 'rack/test'
require 'coveralls'
Coveralls.wear!

module RSpecMixin
  include Rack::Test::Methods
  def app() App end
end

RSpec.configure { |c| c.include RSpecMixin }
