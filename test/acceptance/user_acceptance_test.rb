ENV['RACK_ENV'] = 'test'
require_relative '../helpers/acceptance_helper'
require 'pry'

class UserAcceptanceTest < Minitest::Test
  include Capybara::DSL

  attr_reader :first_user, :second_user

  def setup
    delete_test_db
    user1 = User.new("email" => "simon@example.com")
    user2 = User.new("email" => "geoff@example.com")
    @first_user = UserStore.create(user1)
    @second_user = UserStore.create(user2)
  end

  def teardown
    delete_test_db
  end

  def delete_test_db
    File.delete('./ideabox_test') if File.exists?('./ideabox_test')
  end

  def test_it_displays_email_addresses
    visit '/users'
    assert page.has_content?("simon@example.com")
    assert page.has_content?("geoff@example.com")
  end

  def test_it_can_create_a_new_user
    visit '/users'
    fill_in('user[email]', :with => "Kumar@example.com")
    click_button('sign_up_button')
    assert page.has_content?("Kumar@example.com") #redirect /users
  end

  def test_it_goes_to_user_show_page
    visit '/users/1'
    assert page.has_content?("simon@example.com")
  end

  def test_it_can_post_a_new_idea_for_current_user
    visit '/users/1'
    fill_in('idea[title]', :with => "User 1's big idea")
    fill_in('idea[description]', :with => "User 1's first big idea's description")
    click_button('submit_button')
    assert page.has_content?("User 1's big idea"), "page should display idea title"
    assert page.has_content?("User 1's first big idea's description"), "page should display idea desc"
  end

  def test_user_index_has_button_to_user_show
    visit '/users'
    first('.user_see_more').click_link('See more')
    assert page.has_content?("simon@example.com")
  end

end
