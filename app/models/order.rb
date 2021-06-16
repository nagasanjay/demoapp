class Order < ApplicationRecord
  belongs_to :user
  belongs_to :service
  has_many :order_types
end
