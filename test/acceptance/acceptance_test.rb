ENV['RACK_ENV'] = 'test'
require_relative '../helpers/acceptance_helper'
require 'pry'

class AcceptanceTest < Minitest::Test
  include Capybara::DSL

  def setup
    delete_test_db
    @new_idea = IdeaStore.create("title" => "app", "description" => "social network for penguins", "rank" => 3)
  end

  def teardown
    delete_test_db
  end

  def delete_test_db
    File.delete('./ideabox_test') if File.exists?('./ideabox_test')
  end

  def test_it_doesnt_break
    visit '/'
    assert_equal 200, page.status_code
  end

  def test_it_can_add_an_idea
    visit '/'
    fill_in('idea[title]', :with => "Yeah!")
    fill_in('idea[description]', :with => "booyah idea")
    click_button('submit_button')
    assert page.has_content?('Yeah!')
  end

  def test_it_can_edit_an_idea
    visit '/'
    click_link('Edit')
    fill_in('idea[title]', :with => "NOPE")
    click_button('submit_button')
    assert page.has_content?('NOPE')
  end

  def test_it_can_delete_an_idea
    visit '/'
    assert page.has_content?('penguin')
    click_button('delete')
    refute page.has_content?('penguin')
  end

  def test_it_can_add_to_rank
    visit '/'
    assert page.has_content?("3")
    click_button('+')
    assert page.has_content?("4")
  end

end
