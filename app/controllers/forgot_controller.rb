class ForgotController < ApplicationController

	def show

	end

	def sendmail
		@user = User.find_by(email: params[:forgot][:email])
		if @user
			@user.reset_pin = rand.to_s[2..7].to_i
			if @user.save
				begin
					PasswordsMailer.otp_email(@user).deliver_now
					redirect_to controller: "reset", action: "show", id: @user.id
				rescue => e
					puts "Some error while sending the otp mail #{e}"
				end
			else
			end
		else
			flash.now[:alert] = "No user with this email, please enter correct email address"
			render 'show'
		end
	end
end