class PagesController < ApplicationController
  def home
  end

  def spinner
    puts params[:booking_id]
    #flash[:notice] = "Booking is successful"
    @booking = Booking.find(params[:booking_id])
    #redirect_to controller: "users", action: "show_bookings", id: @booking.user_id
  end
end
