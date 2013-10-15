ENV['RACK_ENV'] = 'test'
require_relative './idea_test_helper'

require_relative '../idea'

class IdeaTest < Minitest::Test
  include Rack::Test::Methods

  def test_it_can_save_idea_to_db
    new_idea = Idea.new("app", "social network for penguins")
    new_idea.save
    assert new_idea
    refute_equal 0, (Idea.database.transaction {|db| db['ideas']}.length)
  end

end
