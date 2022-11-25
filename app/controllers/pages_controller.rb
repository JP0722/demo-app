class PagesController < ApplicationController
  
  def home
  end

  def spinner
    puts params[:booking_id]
    #flash[:notice] = "Booking is successful"
    @booking = Booking.find(params[:booking_id])
    begin
      TwilioClient.new.send_text(@booking.user, "Hi #{@booking.user.name} Your booking has been confirmed from #{@booking.from_date} to #{@booking.to_date} at #{@booking.hotel.name}. Contact us for any other queries")
    rescue => e
      puts "Filed to send sms to user"
    end
    #redirect_to controller: "users", action: "show_bookings", id: @booking.user_id
  end
end
