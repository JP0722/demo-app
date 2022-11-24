class BookingsController < ApplicationController

  before_action :required_user

  def new
  end

  def create
    puts "&"*20
    puts params
    puts "&"*20
    @booking = Booking.new
    @booking.user_id = params[:booking][:user_id]
    @booking.hotel_id = params[:booking][:hotel_id]
    hotel = Hotel.find(@booking.hotel_id)
    @booking.from_date = params[:booking][:from_date]
    @booking.to_date = params[:booking][:to_date]
    @booking.status = 'Booked'
    if @booking.to_date.blank? || @booking.from_date.blank? 
      flash[:alert] = "Dates can't be empty, please try booking again.."
      redirect_to hotel_path(hotel)
      return
    elsif @booking.to_date < @booking.from_date
      flash[:alert] = "End date must be after start date"
      redirect_to hotel_path(hotel)
      return
    end

    ranges = Booking.where("hotel_id = ? AND ? < from_date AND to_date < ? ", @booking.hotel_id, @booking.from_date, @booking.to_date)

    if !ranges.empty?
     flash[:alert] = "You are trying to book some of the unavaiable dates, Please try again.."
     redirect_to hotel_path(hotel)
     return
    end

    price_per_room = hotel.price_per_room
    @booking.price_per_room = price_per_room
    @booking.total_cost = (((@booking.to_date - @booking.from_date).to_i) +1) * @booking.price_per_room

    if @booking.save
      redirect_to controller:"pages", action: "spinner", booking_id: @booking.id
    else
      flash[:notice] = "Failed to book the room"
    end
     
    #redirect_to controller: "users", action: "show_bookings", id: @booking.user_id
  end

  def update
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    flash[:notice] = "Booking has been cancelled successfully"
    redirect_to controller: "users", action: "show_bookings", id: @booking.user_id
  end

  private
  

end
