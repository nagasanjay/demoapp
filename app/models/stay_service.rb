class StayService < ApplicationRecord
    has_one :service, as: :servicable
    has_many :stay_options
end
