class ReviewsController < ApplicationController

  get '/reviews' do

    if !Helpers.is_logged_in?(session)
      flash[:please_login] = "Please login to view content."
      redirect to '/login'
    end

    @reviews = Review.all
    @user = Helpers.current_user(session)

    erb :'/reviews/reviews'

  end

  get '/reviews/:id' do

    if !Helpers.is_logged_in?(session)
      flash[:please_login] = "Please login to view content."
      erb :'/users/login'
    end

    @review = Review.find(params[:id])
    erb :"reviews/show"

  end

end
