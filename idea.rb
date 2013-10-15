require 'yaml/store'

class Idea

  attr_reader :title, :description

  def initialize(title, description)
    @title = title
    @description = description
  end

  def self.all
    database.transaction do |db|
      db['ideas'] || []
    end.map do |data|
      new(data[:title], data[:description])
    end
  end

  def save
    database.transaction do |db|
      db['ideas'] ||= []
      db['ideas'] << {title: title, description: description}
    end
  end

  def self.delete(position)
    database.transaction do
      database['ideas'].delete_at(position)
    end
  end

  def self.database
    unless ENV['RACK_ENV'] == 'test'
      @database ||= YAML::Store.new "ideabox"
    else
      @database ||= YAML::Store.new "ideabox_test"
    end
  end

  def database
    Idea.database
  end

end
