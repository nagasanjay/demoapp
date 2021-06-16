class UserController < ApplicationController

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Signed up successfully.!"
            reset_session
			log_in @user
            redirect_to '/home'
        else
            flash[:danger] = "Signup Failed"
            redirect_to '/'
        end
    end

    def update
        if logged_in?
            if !params["name"].nil?
                @current_user.name = params["name"]
            end
            if !params["email"].nil?
                @current_user.email = params["email"]
            end
            if !params["phone"].nil?
                @current_user.phone_number = params["phone"]
            end
            if !params["locality"].nil?
                @current_user.locality = params["locality"]
            end
            if !params["address"].nil?
                @current_user.address = params["address"]
            end

            if @current_user.save()
                flash[:success] = "Profile updated successfully"
            else
                flash[:danger] = "Update failed"
            end

            return redirect_to '/home'
        else
            flash[:danger] = 'Loggin first'
            redirect_to '/'
        end
    end

    def home
        if logged_in?
            if user_type == "user"
                render "userHome"
            elsif user_type == "vendor"
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

    def changeHome
        if logged_in? and @current_user.userType == "vendor"
            session[:user_type] = session[:user_type] == "vendor" ? "user" : "vendor"
        end
        return redirect_to '/home'
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
