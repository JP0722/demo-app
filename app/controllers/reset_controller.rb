class ResetController < ApplicationController
  def show
  end

  def update_password
    @user = User.find(params[:id])
    puts "%"*20
    puts @user
    puts @user.reset_pin
    puts params[:reset][:reset_pin]
    puts @user.reset_pin == params[:reset][:reset_pin].to_i
    puts "%"*20
    if @user.reset_pin == params[:reset][:reset_pin].to_i
      @user.password = params[:reset][:password]
      @user.reset_pin = 0
      if @user.save
        flash[:notice] = "Password changed successfully"
        redirect_to login_path
      else
        flash[:alert] = "Password change failed, try to resend otp"
        redirect_to forgot_path
      end
    end
  end
end
