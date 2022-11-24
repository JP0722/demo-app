class UsersController < ApplicationController
    
    before_action :required_user, only: [:show_hotels, :show_bookings, :update, :edit]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "#{@user.name} Signed up successfully"
			begin
				UserMailer.welcome_email(@user).deliver_now
			rescue => e
				puts "Some error while sending the welcome mail #{e}"
			end
			redirect_to root_path
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
		@user_hotels = @user.hotels
	end

	def show_hotels
		@hotels = current_user.hotels.order("created_at DESC")
	end

	def show_bookings
		@bookings = current_user.bookings.order("created_at DESC")
		
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = 'User data updated successfully'
			redirect_to user_path(@user)
		else
			render 'edit'
		end
	end


	private
	
	def user_params
		params.require(:user).permit(:name, :email, :phonenumber, :password)
	end
end