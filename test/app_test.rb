ENV['RACK_ENV'] = 'test'

require_relative '../lib/app'
require 'capybara'
require 'capybara/dsl'
require 'test/unit'

class AppTest < Test::Unit::TestCase
  include Capybara::DSL

  def setup
    Capybara.app = Sinatra::Application.new
  end

  def test_it_says_hello_world
    visit '/'
    assert page.has_content?('Hello, World!')
  end

end
