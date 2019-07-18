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

    if params["content"].empty? || params["airport_code"].empty? || params["airport_name"].empty?

       flash[:empty_content_error] = "Fields cannot be empty."
       erb :"/reviews/new"

    else

       review = Review.create(:content => params["content"], :user_id => user.id)
       airport = Airport.create(:airport_code => params["airport_code"], :airport_name => params["airport_name"], :user_id => user.id)
       airport.reviews << review
       user.airports << airport
       @user = Helpers.current_user(session)
       @reviews = Review.all
       flash[:review_created] = "Review created."
       erb :'/reviews/reviews'

    end

  end

  get '/reviews' do

    if !Helpers.is_logged_in?(session)

      flash[:please_login] = "Please login to view content."
      erb :'/users/login'

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
      @user = User.find(@review.user_id)
      erb :"reviews/show"

    end

  end

  get '/reviews/:id/edit' do

    @review = Review.find(params[:id])

    if !Helpers.is_logged_in?(session)

      flash[:login_to_edit] = "Please login to edit a review."
      erb :'/users/login'

    elsif Helpers.current_user(session).id != @review.user_id

      @reviews = Review.all
      @user = Helpers.current_user(session)
      flash[:wrong_user_edit] = "Oops! You can only edit your own reviews."
      erb :'/reviews/reviews'

    else

      erb :"reviews/edit"

    end

  end

  patch '/reviews/:id' do

    @review = Review.find(params[:id])

    if params["content"].empty?

      flash[:no_content_edit] = "An edit must have content"
      erb :"reviews/edit"

    else

      @review.update(:content => params["content"])
      @review.save
      redirect to "/reviews/#{@review.id}"

    end

  end

  post '/reviews/:id/delete' do

    @review = Review.find(params[:id])

    if !Helpers.is_logged_in?(session)

      flash[:delete_error] = "Please login to delete a review."
      erb :'/users/login'

    elsif Helpers.current_user(session).id != @review.user_id

      @user = Helpers.current_user(session)
      @reviews = Review.all
      flash[:wrong_user_delete] = "Oops! You can only delete your own reviews."
      erb :'/reviews/reviews'

    else

      @review.delete
      @user = Helpers.current_user(session)
      @reviews = Review.all
      flash[:success] = "Review deleted."
      erb :'/reviews/reviews'

  end

 end

end
