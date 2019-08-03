class UsersController < ApplicationController

  get '/signup' do

    erb :'users/signup'

  end

  post '/signup' do

      if  params[:username].empty? || params[:email].empty? || params[:password].empty?

          flash.next[:empty_signup_form_error] = "Complete all form fields."
          redirect '/signup'

      elsif !!User.find_by(:username => params["username"])

          flash.next[:username_taken] = "Username taken - please try a different username."
          redirect '/signup'

      else

          user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
          session[:user_id] = user.id
          redirect to '/reviews'

      end

    end

  get '/login' do

    erb :'/users/login'

  end

  post '/login' do

    user = User.find_by(:username => params["username"])

    if user && user.authenticate(params[:password])

      session[:user_id] = user.id
      redirect '/reviews'

    else

      flash.next[:login_error] = "Incorrect login. Try again?"
      redirect '/login'

    end

  end

  get '/logout' do

    if Helpers.is_logged_in?(session)

      session.clear
      flash.now[:logged_out] = "Logged out."
      erb :'/users/logout'

    else

      redirect '/'

    end

  end

end
