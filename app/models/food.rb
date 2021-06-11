class Food < ApplicationRecord
    belongs_to :food_service
    has_many :food_orders
end
