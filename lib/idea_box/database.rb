module Database

  def self.connect
    @@database ||= create_database
  end

  def self.create_database
    unless ENV['RACK_ENV'] == 'test'
      @@database = YAML::Store.new "db/ideabox"
    else
      @@database = YAML::Store.new "ideabox_test"
    end
    @@database.transaction do
      @@database['ideas'] ||= []
    end
    @@database
  end

end
