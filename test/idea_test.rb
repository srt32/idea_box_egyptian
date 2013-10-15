ENV['RACK_ENV'] = 'test'
require_relative './idea_test_helper'

require_relative '../idea'

class IdeaTest < Minitest::Test
  include Rack::Test::Methods

  attr_reader :new_idea

  def setup
    delete_test_db
    @new_idea = Idea.new(title: "app", description: "social network for penguins")
    @new_idea.save
  end

  def teardown
    delete_test_db
  end

  def delete_test_db
    File.delete('./ideabox_test') if File.exists?('./ideabox_test')
  end

  def test_it_can_save_idea_to_db
    refute_equal 0, (Idea.database.transaction {|db| db['ideas']}.length)
  end

  def test_it_can_be_destroyed
    Idea.delete(0)
    assert_equal 0, (Idea.database.transaction {|db| db['ideas']}.length)
  end

  def test_it_can_be_updated
    data = {
      :idea_title => "app",
      :idea_description => "new description penguins"
    }
    Idea.update(0,data)
    assert_equal "new description penguins", (Idea.database.transaction {|db| db['ideas'][0]})[:idea_description]
  end

end
