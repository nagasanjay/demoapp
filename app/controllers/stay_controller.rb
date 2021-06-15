class StayController < ApplicationController
    def create
        if logged_in? and user_type == "vendor"
            p params
            service_id = params["service_id"]

            @service = @current_user.services.find(service_id).servicable

            if @service.nil?
                flash[:danger] = "Invalid service id"
                return redirect_to "/home"
            end

            bed_count = 0
            params["includes"]["bed_type"].each do |type, count|
                bed_count += count.to_i
            end

            @service.stay_options.create!({
                name: params["name"],
                cost: params["cost"],
                room_number: params["room_number"],
                includes: {
                    bed_type: params["includes"]["bed_type"],
                    amenities: params["includes"]["amenities"]
                },
                bed_count: bed_count
            })
            flash[:success] = "Added Stay option"
            return redirect_to "/home"

        else
            flash[:danger] = "Log in as vendor"
            return redirect_to '/home'
        end
    end
end