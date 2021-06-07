class User < ApplicationRecord
    has_many :services
    has_many :foods, through: :orders
end
