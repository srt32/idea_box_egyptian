class IdeaBoxApp < Sinatra::Base
  require_relative './idea'

  configure :development do
    register Sinatra::Reloader
  end

  not_found do
    erb :error
  end

  get '/' do
    erb :index
  end

  post '/' do
    idea = Idea.new("dummy", "dummy yeas")
    idea.save
    "Creating an IDEA!"
  end

end
