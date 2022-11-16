class ForgotController < ApplicationController

	def show

	end

	def sendmail
		user = User.find_by(email: params[:forgot][:email])
		if user
		else
			flash.now[:alert] = "No user with this email, please enter correct email address"
			render 'show'
		end
	end
end