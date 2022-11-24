class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			# This creates a new session
			session[:user_id] = user.id
			flash[:notice] = "#{user.name} logged in successfully"
			redirect_to hotels_path
		else
			flash.now[:alert] = "You have entered wrong login credentials, please try again"
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "User successfully logged out"
		redirect_to login_path
	end
end