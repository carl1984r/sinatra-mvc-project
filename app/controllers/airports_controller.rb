class AirportsController < ApplicationController

  get '/airports' do


    if !Helpers.is_logged_in?(session)

      flash[:please_login] = "Please login to view content."
      erb :'/users/login'

    else

      @airports = User.find_by(:id => session[:user_id]).airports
      erb :"/airports/airports"

    end


  end

end
