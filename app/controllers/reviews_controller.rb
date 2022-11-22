class ReviewsController < ApplicationController
	def create
		@review = Review.new(params.require(:review).permit(:user_id, :hotel_id, :comment, :rating))
		if @review.save
			flash[:notice] = "Review added successfully"
		else
			flash[:alert] = "Failed to add the review"
		end

		@hotel = Hotel.find(params[:review][:hotel_id])
		redirect_to hotel_path(@hotel)
	end

	def destroy
		@review = Review.find(params[:id])
		@hotel = Hotel.find(@review.hotel_id)
		@review.destroy
		flash[:notice] = "Review deleted successfully"
		redirect_to hotel_path(@hotel)
	end
end