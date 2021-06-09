class ApplicationController < ActionController::Base
    include SessionsHelper
    def index
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
