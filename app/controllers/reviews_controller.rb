class ReviewsController < ApplicationController

  get '/reviews/new' do

    if !Helpers.is_logged_in?(session)

      flash[:create_error] = "Please login to create a review."
      erb :'/users/login'

    else

      erb :"/reviews/new"

    end

  end

  post '/reviews' do

    user = Helpers.current_user(session)

    if params["content"].empty?

       flash[:empty_content_error] = "Review must have content."
       erb :"/reviews/new"

    else

       Review.create(:content => params["content"], :user_id => user.id)

       redirect to '/reviews'

    end

  end

  get '/reviews' do

    if !Helpers.is_logged_in?(session)

      flash[:please_login] = "Please login to view content."
      redirect to '/login'

    else

      @reviews = Review.all
      @user = Helpers.current_user(session)
      erb :'/reviews/reviews'

    end

  end

  get '/reviews/:id' do

    if !Helpers.is_logged_in?(session)
      flash[:please_login] = "Please login to view content."
      erb :'/users/login'

    else

      @review = Review.find(params[:id])
      erb :"reviews/show"

    end

  end

  post '/reviews/:id/delete' do

    @review = Review.find(params[:id])

    if !Helpers.is_logged_in?(session)

      flash[:delete_error] = "Please login to create a review."
      erb :'/users/login'

    elsif Helpers.current_user(session).id != @review.user_id

      flash[:wrong_user_error] = "Can only delete own posts."
      erb :'/reviews/reviews'

    else

    @tweet.delete
    redirect to '/reviews'

  end

 end

end
