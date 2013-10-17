ENV['RACK_ENV'] = 'test'
require_relative '../helpers/acceptance_helper'
require 'pry'

class UserAcceptanceTest < Minitest::Test
  include Capybara::DSL

  def setup
    delete_test_db
    @new_idea = UserStore.create("username" => "app",
                                 "id" => 1)
  end

  def teardown
    delete_test_db
  end

  def delete_test_db
    File.delete('./ideabox_test') if File.exists?('./ideabox_test')
  end

  def test_it_doesnt_break
    visit '/users'
    assert_equal 200, page.status_code
  end


end
