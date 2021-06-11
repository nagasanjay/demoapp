class ServiceController < ApplicationController
    def show
        if logged_in?
            service = Service.find(params[:id])
            if service.servicable_type == "FoodService"
                foods = Array.new
                for food in service.servicable.foods
                    foods.append(food.name)
                end
                msg = {
                    :name => service.name,
                    :type => service.servicable_type,
                    :locality => service.servicable.locality,
                    :contact_number => service.servicable.contact_number,
                    :interval => service.servicable.time_interval,
                    :status => service.servicable.status,
                    :foods => foods
                }
            elsif service.servicable_type == "StayService"
                stay_options = Array.new
                for option in service.servicable.stay_options
                    stay_options.last()
                    if stay_options.last() and (stay_options.last()[:name] == option.name)
                        next
                    end
                    stay_options.append({
                        :name => option.name,
                        :includes => option.includes
                    })
                end
                msg = {
                    :name => service.name,
                    :type => service.servicable_type,
                    :locality => service.servicable.locality,
                    :contact_number => service.servicable.contact_number,
                    :address => service.servicable.address,
                    :available => service.servicable.available,
                    :stay_options => stay_options
                }
            end
            render :json => msg
        else
            render :json => {:error => "failed"}
        end
    end
end