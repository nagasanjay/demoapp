json.extract! user, :id, :name, :email, :phone_number, :password, :userType, :locality, :address, :created_at, :updated_at
json.url user_url(user, format: :json)
