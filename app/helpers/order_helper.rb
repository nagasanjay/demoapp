module OrderHelper
    def foodOrder? (order)
        p user_type
        if order.order_types.first.orderable_type == "FoodOrder"
            return true
        else
            return false
        end
    end

    def stayOrder? (order)
        if order.order_types.first.orderable_type == "StayOrder"
            return true
        else
            return false
        end
    end

    def vendorName (order)
        if foodOrder?(order)
            return order.order_types.first.orderable.food.food_service.service.name
        else
            return order.order_types.first.orderable.stay_option.stay_service.service.name
        end
    end

    def orderItems (order)
        items = Array.new
        if foodOrder?(order)
            for item in order.order_types
                items.push(item.orderable.food.name)
            end
        else
            for item in order.order_types
                items.push(item.orderable.stay_option.room_number)
            end
        end

        return items
    end

    def deliveryStatus (order)
        if foodOrder?(order)
            return order.delivered ? "delivered" : "waiting for delivery"
        else
            if order.order_types.first.orderable.checkin.nil?
                return "yet to checkin"
            elsif order.order_types.first.orderable.checkout.nil?
                return "checked in"
            else
                return "checked out"
            end
        end
    end
end