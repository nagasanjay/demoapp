class StayOrder < ApplicationRecord
    belongs_to :stay_option
    has_one :order_type, as: :orderable
end