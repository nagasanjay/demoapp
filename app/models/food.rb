class Food < ApplicationRecord
    belongs_to :food_service
    has_many :orders
    has_many :users, through: :orders
end
