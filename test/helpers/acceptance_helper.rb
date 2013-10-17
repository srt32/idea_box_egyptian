ENV['RACK_ENV'] = 'test'

require_relative '../../lib/app'

require 'bundler'
Bundler.require

require 'rack/test'
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'capybara/dsl'

Capybara.app = IdeaBoxApp
Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app, :headers =>  { 'User-Agent' => 'Capybara' })
end
