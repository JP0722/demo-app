class UsersController < ApplicationController
    
    before_action :required_user, only: [:show_hotels, :show_bookings, :update, :edit, :show_hotels_stats]
    before_action :required_same_user, only: [:updates, :edit, :destroy, :show_hotels, :show_bookings]

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

	def show_hotels_stats
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

	def destroy
		@user = User.find(params[:id])
		session[:user_id] = nil
		@user.destroy
		redirect_to login_path
	end


	private
	
	def user_params
		params.require(:user).permit(:name, :email, :phonenumber, :password)
	end

	def required_same_user
		puts "^"*20
		puts current_user.id
		puts params[:id]
		puts "^"*20
		if (current_user.id != params[:id].to_i)
			flash[:alert] = "You are not allowed to perform this action"
			redirect_to hotels_path
		end
	end
end