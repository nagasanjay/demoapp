# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

OrderType.delete_all
StayOrder.delete_all
StayOption.delete_all
StayService.delete_all
FoodOrder.delete_all
Order.delete_all
Food.delete_all
FoodService.delete_all
Service.delete_all
User.destroy_all


loc = Array["velachery", "Saidapet", "Guindy"]
20.times do |n|
    userType = n%4 != 0 ? "user" : "vendor"
    name = "#{userType}#{n}"
    email = "#{name}@email.com"
    password = "#{name}"
    @user = User.create!(
        name: name,
        email: email,
        phone_number: "9865321470",
        password: password,
        userType: userType,
        locality: loc[n%3],
        address: loc[n%3]
    )

    if userType == "vendor"

        @food_service = FoodService.create!(
            contact_number: @user.phone_number,
            status: "available",
            locality: loc[n%3],
            time_interval: {
                timing: [{
                    start: "08:00",
                    end: "20:00"
                }]
            },
        )

        @service = @user.services.create!(
            name: "#{name} Food Service",
            servicable: @food_service
        )

        @food_service.foods.create!([{
            name: "idly",
            cost: 20,
            units: 2,
            includes: {
                others: ["sambar", "chutney"]
            },
            available_count: 30
        },{
            name: "dosa",
            cost: 30,
            units: 1,
            includes: {
                others: ["sambar", "chutney"]
            },
            available_count: 30
        },{
            name: "pongal",
            cost: 30,
            units: 1,
            includes: {
                others: ["sambar", "chutney"]
            },
            available_count: 30
        },{
            name: "chapathi",
            cost: 40,
            units: 2,
            includes: {
                others: ["vegetable kuruma", "onion"]
            },
            available_count: 30
        },{
            name: "vadai",
            cost: 10,
            units: 1,
            includes: {
                others: [""]
            },
            available_count: 30
        }])

        @stay_service = StayService.create!({
            contact_number: @user.phone_number,
            status: "available",
            locality: loc[n%3],
            available: true
        })

        @user.services.create!(
            name: "#{name} Stay Service",
            servicable: @stay_service
        )

        @stay_service.stay_options.create!([{
            name: "Suite A",
            cost: 500,
            room_number: "A1",
            bed_count: 1,
            available: true,
            includes: {
                amenities: ["AC", "TV"],
                bed_type: {
                    king_size: 0,
                    queen_size: 0,
                    single: 1,
                    double: 0
                }
            }
        },{
            name: "Suite A",
            cost: 500,
            room_number: "A2",
            bed_count: 1,
            available: true,
            includes: {
                amenities: ["AC", "TV"],
                bed_type: {
                    king_size: 0,
                    queen_size: 0,
                    single: 1,
                    double: 0
                }
            }
        },{
            name: "Suite B",
            cost: 1000,
            room_number: "B1",
            bed_count: 2,
            available: true,
            includes: {
                amenities: ["AC", "TV"],
                bed_type: {
                    king_size: 0,
                    queen_size: 0,
                    single: 2,
                    double: 0
                }
            }
        },{
            name: "Suite B",
            cost: 1000,
            room_number: "B2",
            bed_count: 2,
            available: true,
            includes: {
                amenities: ["AC", "TV"],
                bed_type: {
                    king_size: 0,
                    queen_size: 0,
                    single: 2,
                    double: 0
                }
            }
        },{
            name: "Suite C",
            cost: 1500,
            room_number: "C1",
            bed_count: 1,
            available: true,
            includes: {
                amenities: ["AC", "TV"],
                bed_type: {
                    king_size: 1,
                    queen_size: 0,
                    single: 0,
                    double: 0
                }
            }
        }])

    else
        
        @service = Service.first
        @order = @service.orders.create!(user_id: @user.id)

        @foods = @service.servicable.foods
        @food_orders = FoodOrder.create!([{
            food_id: @foods.first.id,
            quantity: 2,
            cost: @foods.first.cost * 2
        },{
            food_id: @foods.last.id,
            quantity: 1,
            cost: @foods.last.cost
        }])

        for fo in @food_orders
            @order.order_types.create!({
                orderable: fo
            })
        end
        
        for order_type in @order.order_types
            cost = @order.cost ? @order.cost : 0
            @order.cost =  cost + order_type.orderable.cost
        end

        @order.delivered = false
        @order.save()

        @service = Service.last
        @stay_order = @service.orders.create!(user_id: @user.id)

        @stay_option = @service.servicable.stay_options.last
        @s_order = @stay_option.stay_orders.create!({cost: @stay_option.cost})

        @stay_order.order_types.create!({orderable: @s_order})
        @stay_order.delivered = true
        @stay_order.save()

    end
end

p "Created #{User.count} users"
p "Created #{Service.count} services"
p "Created #{FoodService.count} food services"
p "Created #{Food.count} foods"
p "Created #{Order.count} orders"
p "Created #{FoodOrder.count} food orders"
p "Created #{StayService.count} stay services"
p "Created #{StayOption.count} stay options"
p "Created #{StayOrder.count} stay orders"