class SessionsController < ApplicationController

	def create
		@user = User.find_by(email: params[:session][:email].downcase)
		if @user && @user.authenticate(params[:session][:password])
			reset_session
			log_in @user
			redirect_to '/'
		else
			flash[:danger] = "AUthentication failed"
			redirect_to '/'
		end
	end

	def destroy
		log_out
		flash[:success] = "Logged Out successfully"
		redirect_to '/'
	end
end
