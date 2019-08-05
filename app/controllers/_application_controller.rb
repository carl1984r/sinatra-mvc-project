class ApplicationController < Sinatra::Base


  register Sinatra::Flash

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

      erb :index

    end

 helpers do

   def redirect_if_not_logged_in

   end

 end

 end

end
