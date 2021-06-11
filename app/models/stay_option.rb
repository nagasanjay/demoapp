class StayOption < ApplicationRecord
    belongs_to :stay_service
    has_many :stay_orders
end
