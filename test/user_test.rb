ENV['RACK_ENV'] = 'test'
require_relative './helpers/user_test_helper'

require_relative '../lib/idea_box/user'

class UserTest < Minitest::Test
  include Rack::Test::Methods

  attr_reader :new_user

  def setup
    delete_test_db
    @new_user = UserStore.create("email" => "simon@example.com")
  end

  def teardown
    delete_test_db
  end

  def delete_test_db
    File.delete('./ideabox_test') if File.exists?('./ideabox_test')
  end

  def test_it_can_save_to_db
    refute_equal 0, (UserStore.database.transaction {|db| db['users']}.length)
  end

  # feels like UserStore should create users but delegate setting an id to user
  # maybe pass UserStore.create a User object instead of a hash
  # in that way, the user class can validate email and serialize an id
  def test_it_responds_to_email
    
  end

  def test_it_responds_to_id

  end

  def test_it_can_be_destroyed

  end

  def test_it_can_be_updated

  end

end
