module SessionsHelper
    def log_in(user)
        flash[:success] = "Logged In successfully"
        session[:user_id] = user.id
        session[:user_type] = user.userType
    end
    # Returns the current logged-in user (if any).
    def current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def user_type
        return session[:user_type]
    end

    def logged_in?
        !current_user.nil?
    end

    def log_out
        reset_session
        @current_user = nil
    end
end
