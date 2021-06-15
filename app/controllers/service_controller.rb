class ServiceController < ApplicationController
    def show
        if logged_in?
            service = Service.find(params[:id])
            if service.servicable_type == "FoodService"
                msg = {
                    :ID => service.id,
                    :name => service.name,
                    :type => service.servicable_type,
                    :locality => service.servicable.locality,
                    :contact_number => service.servicable.contact_number,
                    :interval => service.servicable.time_interval,
                    :status => service.servicable.status,
                    :foods => service.servicable.foods
                }
            elsif service.servicable_type == "StayService"
                stay_options = Array.new
                for option in service.servicable.stay_options
                    stay_options.last()
                    if stay_options.last() and (stay_options.last()[:name] == option.name)
                        stay_options.last()[:count] += 1
                        if option.available
                            stay_options.last()[:available] += 1
                        end
                        next
                    end
                    stay_options.append({
                        :name => option.name,
                        :includes => option.includes,
                        :count => 1,
                        :available => option.available ? 1 : 0,
                        :cost => option.cost
                    })
                end
                msg = {
                    :ID => service.id,
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

    def create
        if logged_in? and user_type == "vendor"
            p params
            if params["type"] == "FoodService"
                @food_service = FoodService.create!(
                    contact_number: params["contact"],
                    status: "available",
                    locality: params["locality"],
                    time_interval: {
                        timing: [{
                            start: params["timing"]["from"],
                            end: params["timing"]["to"]
                        }]
                    },
                )
        
                @service = @current_user.services.create!(
                    name: params["name"],
                    servicable: @food_service
                )

                flash[:success] = "Created Service"
                return redirect_to "/home"
            elsif params["type"] == "StayService"
                @stay_service = StayService.create!({
                    contact_number: params["contact"],
                    status: "available",
                    locality: params["locality"],
                    address: params["address"],
                    available: true
                })
        
                @current_user.services.create!(
                    name: params["name"],
                    servicable: @stay_service
                )

                flash[:success] = "Created Service"
                return redirect_to "/home"
            end
        else
            render :json => {:error => "failed"}
        end
    end

    
    def search
        if logged_in?  
            if params["search"].blank?  
                flash[:warning] = "nothing to search"
                return redirect_to "/home"   
            else  
                @parameter = params["search"].downcase  
                @results = Service.all.where("lower(name) LIKE :search", search: @parameter)
                
                render :json => @results
            end
        else
            flash[:danger] = "loggin first"
            return redirect_to "/"  
    end
end