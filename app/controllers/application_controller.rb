class ApplicationController < ActionController::Base
    include SessionsHelper
    include OrderHelper

    def index
        if logged_in?
            redirect_to '/home'
        end
    end


    def logged_in?
        !current_user.nil?
    end

    def authorized
        redirect_to '/' unless logged_in?
    end
end
