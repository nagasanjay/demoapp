class UserController < ApplicationController

    def create
        @user = User.new(user_params)
        check = User.find_by(email: @user.email)

        if !check.nil?
            flash[:danger] = "email exists"
            return redirect_to '/'
        end

        if @user.password.length < 8
            flash[:danger] = "enter a password with atleast 8 characters"
            return redirect_to '/'
        end

        if @user.phone_number.length != 10 or @user.phone_number[0] == '-'
            flash[:danger] = "enter a valid 10 digit mobile number"
            return redirect_to '/'
        end

        if @user.address.length > 150 || @user.locality.length > 150
            flash[:danger] = "address cannot exceed 150 characters"
            return redirect_to '/'
        end

        if @user.save
            flash[:success] = "Signed up successfully.!"
            reset_session
			log_in @user
            return redirect_to '/home'
        else
            flash[:danger] = "Signup Failed"
            return redirect_to '/'
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
        p params
        params[:user].each { |key, value| value.strip! }
        params.require(:user).permit(:name, :email, :password, 
            :locality, :address, :phone_number, :userType)
    end
end
