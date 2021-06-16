class Service < ApplicationRecord
  belongs_to :servicable, polymorphic: true
  belongs_to :user
  has_many :orders
end
