class ApplicationController < Sinatra::Base


  register Sinatra::Flash

  configure do
    enable :sessions
    set :session_secret, "glyyph"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  helpers do

    def redirect_if_not_logged_in

      if !Helpers.is_logged_in?(session)

        flash.next[:please_login] = "Please login to continue."
        redirect '/login'

      end

    end

    def redirect_if_incorrect_user

      if Helpers.current_user(session).id != @review.user_id

        flash.next[:wrong_user_edit] = "Oops! You can only modify your own reviews."
        redirect '/reviews'

      end

    end

  end

  get '/' do

    if Helpers.is_logged_in?(session)

      redirect to '/reviews'

    else

      erb :index

    end

  end

end
