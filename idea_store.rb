class IdeaStore

  require 'yaml/store'

  def self.all
    database.transaction do |db|
      db['ideas'] || []
    end.map do |data|
      Idea.new(data)
    end
  end

  def self.create(attributes)
    database.transaction do
      database['ideas'] ||= []
      database['ideas'] << attributes
    end
  end

  def self.delete(position)
    database.transaction do
      database['ideas'].delete_at(position)
    end
  end

  def self.update(id, data)
    database.transaction do
      database['ideas'][id] = data
    end
  end

  def self.find(id)
    raw_idea = find_raw_idea(id)
    Idea.new(raw_idea)
  end

  def self.find_raw_idea(id)
    database.transaction do
      database['ideas'].at(id)
    end
  end

  def self.database
    unless ENV['RACK_ENV'] == 'test'
      @database ||= YAML::Store.new "ideabox"
    else
      @database ||= YAML::Store.new "ideabox_test"
    end
  end

end
