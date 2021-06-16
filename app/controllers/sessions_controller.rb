class SessionsController < ApplicationController

	def create
		@user = User.find_by(email: params[:session][:email].strip.downcase)
		if @user && @user.authenticate(params[:session][:password])
			reset_session
			log_in @user
			redirect_to '/home'
		else
			flash[:danger] = "Authentication failed"
			redirect_to '/'
		end
	end

	def destroy
		log_out
		flash[:success] = "Logged Out successfully"
		redirect_to '/'
	end
end
