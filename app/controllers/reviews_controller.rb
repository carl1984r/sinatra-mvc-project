class ReviewsController < ApplicationController

  get '/reviews/new' do

    if !Helpers.is_logged_in?(session)

      flash.next[:create_error] = "Please login to create a review."
      redirect '/login'

    else

      erb :"/reviews/new"

    end

  end

  post '/reviews' do

    user = Helpers.current_user(session)

    if params["content"].empty? || params["airport_code"].empty? || params["airport_name"].empty?

       flash.next[:empty_content_error] = "Fields cannot be empty."
       redirect '/reviews/new'

    else

       review = Review.create(:content => params["content"], :user_id => user.id)
       !!user.airports.find_by(:airport_code => params["airport_code"].upcase) ? airport = user.airports.find_by(:airport_code => params["airport_code"].upcase) : airport = Airport.create(:airport_code => params["airport_code"].upcase, :airport_name => params["airport_name"], :user_id => user.id)
       airport.reviews << review
       flash.next[:review_created] = "Review created."
       redirect '/reviews'

    end

  end

  get '/reviews' do

    if !Helpers.is_logged_in?(session)

      flash.next[:please_login] = "Please login to view content."
      redirect '/login'

    else

      @reviews = Review.all
      @user = Helpers.current_user(session)
      erb :'/reviews/reviews'

    end

  end

  get '/reviews/:id' do

   if !Review.all.detect {|x| x if params[:id].to_i == x.id}.nil?

    if !Helpers.is_logged_in?(session)

      flash.next[:please_login] = "Please login to view content."
      redirect '/login'

    else

      @review = Review.find(params[:id])
      @user = User.find(@review.user_id)
      erb :"reviews/show"

    end

   else

    redirect to '/reviews'

   end

  end

  get '/reviews/:id/edit' do

    @review = Review.find(params[:id])

    if !Helpers.is_logged_in?(session)

      flash.next[:login_to_edit] = "Please login to edit a review."
      redirect '/login'

    elsif Helpers.current_user(session).id != @review.user_id

      flash.next[:wrong_user_edit] = "Oops! You can only edit your own reviews."
      redirect '/reviews'

    else

      @review = Review.find(params[:id])
      erb :"reviews/edit"

    end

  end

  patch '/reviews/:id' do

    @review = Review.find(params[:id])

    if params["content"].empty?

      flash.now[:no_content_edit] = "An edit must have content."
      erb :"reviews/edit"

    elsif Helpers.current_user(session).id != @review.user_id

      flash.next[:wrong_user_edit] = "Oops! You can only edit your own reviews."
      redirect '/reviews'

    else

      @review.update(:content => params["content"])
      @review.save
      flash.next[:edit_successful] = "Edit successful."
      redirect '/reviews'

    end

  end

  post '/reviews/:id/delete' do

     @review = Review.find(params[:id])

     if !Helpers.is_logged_in?(session)

       flash.next[:delete_error] = "Please login to delete a review."
       redirect '/login'

     elsif Helpers.current_user(session).id != @review.user_id

       flash.next[:wrong_user_delete] = "Oops! You can only delete your own reviews."
       redirect '/reviews'

     else

       @review.delete
       flash.next[:success] = "Review deleted."
       redirect '/reviews'

     end

  end

end
