json.extract! food, :id, :name, :cost, :units, :includes, :available_count, :food_service_id, :created_at, :updated_at
json.url food_url(food, format: :json)
