class FoodService < ApplicationRecord
    has_one :service, as: :servicable
    has_many :food
end
