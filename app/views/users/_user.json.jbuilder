json.extract! user, :id, :username, :first_name, :last_name, :last_login, :password_hash, :password_salt, :created_at, :updated_at
json.url user_url(user, format: :json)
