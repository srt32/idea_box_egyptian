ENV['RACK_ENV'] = 'test'
require_relative './test_helper'

require_relative '../app'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    IdeaBoxApp
  end

  def test_it_says_hello_world
    get '/'
    assert last_response.ok?
  end

  def test_it_routes_to_root_post
    post '/'
    assert last_response.ok?
  end

end