class ReviewsController < ApplicationController

  get '/reviews/new' do

      redirect_if_not_logged_in
      erb :"/reviews/new"

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

      redirect_if_not_logged_in
      @reviews = Review.all
      @user = Helpers.current_user(session)
      erb :'/reviews/reviews'

  end

  get '/reviews/:id' do

   if  !!Review.find_by(:id => params[:id])

      redirect_if_not_logged_in
      @review = Review.find(params[:id])
      @user = User.find(@review.user_id)
      erb :"reviews/show"

   else

    redirect to '/reviews'

   end

  end

  get '/reviews/:id/edit' do

      @review = Review.find(params[:id])

      redirect_if_not_logged_in
      redirect_if_incorrect_user

      @review = Review.find(params[:id])
      erb :"reviews/edit"

  end

  patch '/reviews/:id' do

    @review = Review.find(params[:id])

    redirect_if_incorrect_user

    if params["content"].empty?

      flash.next[:no_content_edit] = "An edit must have content."
      redirect back

    else

      @review.update(:content => params["content"])
      @review.save
      flash.next[:edit_successful] = "Edit successful."
      redirect '/reviews'

    end

  end

  post '/reviews/:id/delete' do

     @review = Review.find(params[:id])

     redirect_if_not_logged_in
     redirect_if_incorrect_user

     @review.delete
     flash.next[:success] = "Review deleted."
     redirect '/reviews'

  end

end
