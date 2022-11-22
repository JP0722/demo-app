class HotelsController < ApplicationController

	before_action :set_hotel, only: [:show, :edit, :update, :destroy]
	before_action :required_user
	before_action :required_same_user, only: [:edit, :update, :destroy]

	def new
		@hotel = Hotel.new
		@booking = Booking.new
	end

	def show
		@reviews = Review.where(hotel_id: params[:id])
		@rating_avg = Review.where(hotel_id: params[:id]).average(:rating)
	end

	def index
		print_debug params[:name]
		if !params[:name].blank?
			@hotels = Hotel.where("lower(name) like ? OR lower(address) like ? OR lower(description like ?)", 
									"%#{params[:name].downcase}%", "%#{params[:name].downcase}%", "%#{params[:name].downcase}%").paginate(page: params[:page], per_page: 3)
		else
			@hotels = Hotel.paginate(page: params[:page], per_page: 3)
		end
	end

	def create
		@hotel = Hotel.new(hotel_params)
		print_debug params
		@hotel.user_id = current_user.id
		if @hotel.save
			flash[:notice] = "Hotel info has been successfully updated"
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
	end

	def updated
	end

	def destroy
		@hotel.destroy
		redirect_to user_path(current_user)
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