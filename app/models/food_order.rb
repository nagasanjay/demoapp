class FoodOrder < ApplicationRecord
    belongs_to :food
    has_one :order_type, as: :orderable
end