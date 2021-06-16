class OrderController < ApplicationController
    def create
        if logged_in?
            service_id = params["service_id"]
            service = Service.find(service_id)
            service_type = params["service"]
            items = params["items"]

            p items.nil?
            if items.nil?
                flash[:warning] = "nothing to order"
                return redirect_to "/"
            end

            if service_type == "FoodService" and orderFood(items:items, service: service)
                flash[:success] = "Order placed successfully"
            elsif service_type == "StayService" and orderStay(items:items, service: service)
                    flash[:success] = "Order placed successfully"
            else
                flash[:danger] = "Order failed"
            end
            return redirect_to "/"
        else
            flash[:danger] = "Login First"
            return redirect_to "/"
        end
    end

    def deliver
        if logged_in? and user_type == "vendor"
            order_id = params["order_id"].to_i
            order = Order.find(order_id)
            order.delivered = true
            if order.save()
                flash[:success] = "Order delivered"
            else
                flash[:danger] = "Failed to deliver"
            end
            return redirect_to '/home'
        else
            flash[:danger] = "Loggin as vendor"
            return redirect_to '/'
        end
    end

    def checkin
        if logged_in? and user_type == "vendor"
            order_id = params["order_id"].to_i
            order = Order.find(order_id)

            for stay in order.order_types
                stay.orderable.checkin = DateTime.now
                if !stay.orderable.save()
                    flash[:danger] = "Failed to checkin"
                    return redirect_to '/home'
                end
            end

            flash[:success] = "Checked in"
            return redirect_to '/home'
        else
            flash[:danger] = "Loggin as vendor"
            return redirect_to '/'
        end
    end

    def checkout
        if logged_in? and user_type == "vendor"
            order_id = params["order_id"].to_i
            order = Order.find(order_id)

            for stay in order.order_types
                stay.orderable.checkout = DateTime.now
                stay.orderable.stay_option.available = true
                if !stay.orderable.save()
                    flash[:danger] = "Failed to checkout"
                    return redirect_to '/home'
                end
                if !stay.orderable.stay_option.save()
                    flash[:danger] = "Failed to checkout"
                    return redirect_to '/home'
                end
            end

            flash[:success] = "Checked out"
            return redirect_to '/home'
        else
            flash[:danger] = "Loggin as vendor"
            return redirect_to '/'
        end
    end

    private
    def orderFood(items:, service:)
        service_id = service.servicable_id
        @order = service.orders.create!(user_id: @current_user.id)

        orders = Array.new
        items.each do |index, food|
            if food["count"].to_i == 0
                next
            end
            f = Food.find_by(name: food["name"], food_service_id: service_id)
            orders.append({
                food_id: f.id,
                quantity: food["count"].to_i,
                cost: f.cost * food["count"].to_i
            })
            f.available_count -= food["count"].to_i;
            f.save();
        end
        p orders

        if orders.length == 0
            flash[:warning] = "nothing to order"
            return false
        end

        @food_orders = FoodOrder.create!(orders)

        for food in @food_orders
            @order.order_types.create!({
                orderable: food
            })
        end
        
        for order_type in @order.order_types
            cost = @order.cost ? @order.cost : 0
            @order.cost =  cost + order_type.orderable.cost
        end

        @order.delivered = false
        return @order.save()
    end

    private
    def orderStay(items:, service:)
        service_id = service.servicable_id
        @stay_order = service.orders.create!(user_id: @current_user.id)
        
        p service_id

        rooms = "Booked"
        cost = 0

        items.each do |index, stay|
            i = 0
            p stay["name"]
            while i < stay["count"].to_i
                s = StayOption.find_by(name: stay["name"], available: true, stay_service_id: service_id)
                s.available = false
                rooms += " " + s.room_number

                s_order = s.stay_orders.create!({cost: s.cost})
                cost += s.cost
                @stay_order.save()

                @stay_order.order_types.create!({orderable: s_order})

                if !s.save()
                    return false
                end
                i += 1
            end
        end
        
        if rooms == "Booked"
            flash[:warning] = "nothing to order"
            return false
        end

        flash[:info] = rooms
        @stay_order.cost = cost
        @stay_order.delivered = true
        return @stay_order.save()
    end
end