require_relative './database.rb'
require 'yaml/store'
require 'pry'

class UserStore
  extend Database

  def self.create(attributes)
    database.transaction do
      database['users'] ||= []
      database['users'] << attributes
    end
  end

  def self.database
    Database.connect
  end

end
