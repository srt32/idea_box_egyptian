ENV['RACK_ENV'] = 'test'
require_relative '../helpers/acceptance_helper'

class AcceptanceTest < Minitest::Test
  include Capybara::DSL


  def test_it_doesnt_break
    visit '/'
    assert_equal 200, page.status_code
  end

    #describe "shows a site", type: :feature do
    #  it "return 200" do
    #    visit '/'
    #    assert_equal 200, page.status_code
    #  end
    #end

end
