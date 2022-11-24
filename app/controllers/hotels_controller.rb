class HotelsController < ApplicationController

	before_action :set_hotel, only: [:show, :edit, :update, :destroy, :show_bookings]
	before_action :required_user
	before_action :required_same_user, only: [:edit, :update, :destroy, :show_bookings]

	def new
		@hotel = Hotel.new
	end

	def show
		@min_available_date = Time.zone.now
		if !@hotel.available_from_date.nil?
			@min_available_date = (Time.zone.now < @hotel.available_from_date) ? @hotel.available_from_date : Time.zone.now
		end
		@reviews = Review.where(hotel_id: params[:id])
		@rating_avg = Review.where(hotel_id: params[:id]).average(:rating)
		@booking = Booking.new
		@hotel_owner = User.find(@hotel.user_id)
	end

	def index
		print_debug params[:name]
		if !params[:name].blank?
			@hotels = Hotel.order("created_at DESC").where("lower(name) like ? OR lower(address) like ? OR lower(description like ?)", 
									"%#{params[:name].downcase}%", "%#{params[:name].downcase}%", "%#{params[:name].downcase}%").paginate(page: params[:page], per_page: 3)
		else
			@hotels = Hotel.order("created_at DESC").paginate(page: params[:page], per_page: 3)
		end
	end

	def create
		@hotel = Hotel.new(hotel_params)
		print_debug params
		@hotel.user_id = current_user.id
		if @hotel.save
			flash[:notice] = "Space has been successfully created"
			redirect_to hotel_path(@hotel)
		else
			render 'new'
		end
	end

	def show_bookings
		@bookings = @hotel.bookings.order("created_at DESC")
	end

	def edit
	end

	def update
		if @hotel.available_from_date < params[:hotel][:available_from_date].to_date
			ranges = Booking.where("hotel_id = ? AND ((? < from_date AND from_date <= ?) OR (? < to_date AND to_date <= ?))",
											@hotel.id, @hotel.available_from_date, params[:hotel][:available_from_date], @hotel.available_from_date, params[:hotel][:available_from_date])
			
			puts "********** start date **********"
			puts ranges
			puts "********************************"
			if !ranges.empty?
				flash.now[:alert] = "There are some bookings done, in the dates that you tried to edit"
				render 'edit'
				return
			end
		end

		if @hotel.available_to_date > params[:hotel][:available_to_date].to_date
			ranges = Booking.where("hotel_id = ? AND ((? < from_date AND from_date <= ?) OR (? < to_date AND to_date <= ?)) ",
											@hotel.id, params[:hotel][:available_to_date], @hotel.available_to_date, params[:hotel][:available_to_date], @hotel.available_to_date)
			
			puts "********** end date **********"
			puts ranges
			puts "********************************"
			if !ranges.empty?
				flash.now[:alert] = "There are some bookings done, in the dates that you tried to edit"
				render 'edit'
				return
			end
		end
		if @hotel.update(hotel_params)
			flash[:notice] = "Space #{@hotel.name} has been updated successfully"
			redirect_to hotel_path(@hotel)
		else
			flash.now[:alert] = "Updating space failed"
			render 'edit'
		end
	end

	def destroy
		@hotel.destroy
		redirect_to controller:"users", action: "show_hotels", id: current_user.id
	end



	private

	def set_hotel
		@hotel = Hotel.find(params[:id])
	end

	def hotel_params
		params.require(:hotel).permit(:name, :description, :address, :price_per_room, 
									   :ac, :wifi, :parking, :image, :available_from_date, :available_to_date)
	end

	def required_same_user
		if !(current_user.id == @hotel.user_id)
			flash[:alert] = 'You cannot perform this action'
		end
	end

	def print_debug(some_val)
		puts "-"*20
		puts some_val
		puts "-"*20
	end
end