ENV['RACK_ENV'] = 'test'
require_relative './helpers/user_test_helper'

require_relative '../lib/idea_box/user'

class UserTest < Minitest::Test
  include Rack::Test::Methods

end
