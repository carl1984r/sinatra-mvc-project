class ApplicationController < Sinatra::Base


  use Rack::Flash

  configure do
    enable :sessions
    set :session_secret, "glyyph"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

    erb :new


  end

end
