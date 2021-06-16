class FoodController < ApplicationController
    def create
        if logged_in? and user_type == "vendor"
            p params
            service_id = params["service_id"].to_i
            @service = @current_user.services.find(service_id).servicable

            if @service.nil?
                flash[:danger] = "Invalid service id"
                return redirect_to "/"
            end

            @food = @service.foods.create!({
                name: params["name"],
                cost: params["cost"].to_i,
                units: params["units"].to_i,
                available_count: params["available_count"].to_i,
                includes: {
                    others: params["includes"]
                }
            })

            flash[:success] = "Added Food"
            return redirect_to "/home"
        else
            flash[:danger] = "Login as vendor First"
            return redirect_to "/"
        end
    end

    def update
        if logged_in? and user_type == "vendor"
            p params
            service_id = params["service_id"].to_i
            @service = @current_user.services.find(service_id).servicable
            p @service

            if @service.nil?
                flash[:danger] = "Invalid service id"
                return redirect_to "/"
            end

            items = params["data"]
            if items.nil?
                flash[:warning] = "nothing to change"
                return redirect_to "/"
            end

            items.each do |name, count|
                food = @service.foods.find_by(name: name)
                food.available_count = count.to_i

                if !food.save()
                    flash[:danger] = "Failed to change"
                    return redirect_to '/home'
                end
            end

            flash[:success] = "Changed food availablity"
            return redirect_to '/home'
        else
            flash[:danger] = "Login as vendor First"
            return redirect_to "/"
        end
    end
end