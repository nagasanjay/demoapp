module OrderHelper
    def foodOrder? (order)
        p user_type
        if order.service.servicable_type == "FoodService"
            return true
        else
            return false
        end
    end

    def stayOrder? (order)
        if order.service.servicable_type == "StayService"
            return true
        else
            return false
        end
    end

    def vendorName (order)
        if foodOrder?(order)
            return order.service.name
        else
            return order.service.name
        end
    end

    def userDetails (order)
        details = {
            name: order.user.name,
            address: order.user.address,
            contact: order.user.phone_number
        }
    end

    def orderItems (order)
        items = Array.new
        if foodOrder?(order)
            for item in order.order_types
                items.push("#{item.orderable.food.name} x #{item.orderable.quantity}")
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