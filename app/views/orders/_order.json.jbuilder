json.extract! order, :id, :quantity, :cost, :delivered, :user_id, :food_id, :created_at, :updated_at
json.url order_url(order, format: :json)
