class UsersController < ApplicationController

  get '/signup' do

    erb :'users/signup'

  end

  post '/signup' do

      if  params[:username].empty? || params[:email].empty? || params[:password].empty?

          flash[:empty_signup_form_error] = "Complete all form fields."
          erb :'users/signup'

      else

          user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
          session[:user_id] = user.id
          erb :'/reviews/reviews'

      end

    end

  get '/login' do

    erb :'/users/login'

  end

  post '/login' do

    user = User.find_by(:username => params["username"])

    if user && user.authenticate(params[:password])

      @user = user
      @reviews = Review.all
      session[:user_id] = user.id
      erb :'/reviews/reviews'

    else

      flash[:login_error] = "Incorrect login. Try again?"
      erb :'/users/login'

    end

  end

  get '/logout' do

    if Helpers.is_logged_in?(session)

      session.clear
      flash[:logged_out] = "You are now logged out."
      erb :'/users/login'

    else

      erb :index

    end

  end

end
