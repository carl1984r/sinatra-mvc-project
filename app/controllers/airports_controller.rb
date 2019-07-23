class AirportsController < ApplicationController

  get '/airports' do


    if !Helpers.is_logged_in?(session)

      flash[:please_login] = "Please login to view content."
      erb :'/users/login'

    else

      @airports = User.find_by(:id => session[:user_id]).airports
      @user = Helpers.current_user(session)
      erb :"/airports/airports"

    end

  end

  get '/airports/:id' do


    if !Helpers.is_logged_in?(session)

      flash[:please_login] = "Please login to view content."
      erb :'/users/login'


    else

      @airport = Airport.find(params[:id])
      @user = Helpers.current_user(session)
      erb :"airports/show"

    end

  end

end
