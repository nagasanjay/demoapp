# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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

        @food_service.food.create!([{
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

    else 
        Order.create!([{
            quantity: 2,
            cost: Food.first.cost * 2,
            delivered: false,
            food_id: Food.first.id,
            user_id: @user.id
        },{
            quantity: 1,
            cost: Food.last.cost,
            delivered: true,
            food_id: Food.last.id,
            user_id: @user.id
        }])

    end
end

p "Created #{User.count} users"
p "Created #{Service.count} services"
p "Created #{FoodService.count} food services"
p "Created #{Food.count} foods"
p "Creatd #{Order.count} orders"