class ApplicationController < ActionController::Base
    include SessionsHelper
    def index
        if logged_in?
            redirect_to '/home'
        end
    end

    helper_method :current_user
    helper_method :logged_in?

    def logged_in?
        !current_user.nil?
    end

    def authorized
        redirect_to '/' unless logged_in?
    end
end
