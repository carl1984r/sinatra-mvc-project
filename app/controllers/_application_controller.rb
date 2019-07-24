class ApplicationController < Sinatra::Base


  use Rack::Flash, :sweep => true

  configure do
    enable :sessions
    set :session_secret, "glyyph"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

    if Helpers.is_logged_in?(session)

      redirect to '/reviews'

    else

      redirect '/'

    end

  end

end
