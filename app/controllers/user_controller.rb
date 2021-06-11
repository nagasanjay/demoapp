class UserController < ApplicationController

    def create
        byebug
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Signed up successfully.!"
            reset_session
			log_in @user
            render "home"
        else
            flash[:danger] = "Signup Failed"
            redirect_to '/'
        end
    end

    def home
        if logged_in?
            if current_user.userType == "user"
                render "userHome"
            elsif current_user.userType == "vendor"
                render "vendorHome"
            end
        else
            flash[:danger] = 'Loggin first'
            redirect_to '/'
        end
    end

    def userHome
    end

    def vendorHome
    end

    def show
        @user = User.find(params[:id])
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :password, 
            :locality, :address, :phone_number, :userType)
    end
end
