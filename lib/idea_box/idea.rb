class Idea
  include Comparable

  attr_reader :title, :description, :rank

  def initialize(attributes = {})
    @title = attributes["title"]
    @description = attributes["description"]
    @rank = attributes["rank"] || 0
  end

  def like!
    @rank += 1
  end

  def save
    IdeaStore.create(to_h)
  end

  def <=>(other)
    other.rank <=> rank
  end

  def to_h
    {
      "title" => title,
      "description" => description,
      "rank" => rank
    }
  end

end
