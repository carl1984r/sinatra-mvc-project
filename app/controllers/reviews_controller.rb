class ReviewsController < ApplicationController

  get '/reviews' do

    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end

    @reviews = Review.all
    @user = Helpers.current_user(session)

    erb :'/reviews/reviews'

  end

end
