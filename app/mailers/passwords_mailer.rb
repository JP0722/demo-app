class PasswordsMailer < ApplicationMailer

	def otp_email(user)
		@user = user
		mail(to: @user.email, subject: 'Forgot Password Pin')
	end

end
