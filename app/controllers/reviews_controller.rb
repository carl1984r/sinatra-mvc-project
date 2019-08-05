class ReviewsController < ApplicationController

  get '/reviews/new' do

    if redirect_if_not_logged_in

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

    if redirect_if_not_logged_in

    else

      @reviews = Review.all
      @user = Helpers.current_user(session)
      erb :'/reviews/reviews'

    end

  end

  get '/reviews/:id' do

  if  !!Review.find_by(:id => params[:id])

    if redirect_if_not_logged_in

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

    if redirect_if_not_logged_in

    elsif redirect_if_incorrect_user

    else

      @review = Review.find(params[:id])
      erb :"reviews/edit"

    end

  end

  patch '/reviews/:id' do

    @review = Review.find(params[:id])

    if params["content"].empty?

      flash.next[:no_content_edit] = "An edit must have content."
      redirect back

    elsif redirect_if_incorrect_user

    else

      @review.update(:content => params["content"])
      @review.save
      flash.next[:edit_successful] = "Edit successful."
      redirect '/reviews'

    end

  end

  post '/reviews/:id/delete' do

     @review = Review.find(params[:id])

     if redirect_if_not_logged_in

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
