require 'dotenv/load'

SECRET_KEY = ENV['JWT_SECRET_KEY']

class ApplicationController < ActionController::API
    before_action :authorized

    def encode_token(id)
        JWT.encode({user_id: id}, SECRET_KEY)
    end
      
    def auth_header
        # { Authorization: 'Bearer <token>' }
        request.headers["Authorization"]
    end

    def decode_token
        begin
            token = auth_header.split(" ")[1]
            JWT.decode(token, SECRET_KEY)[0]["user_id"]
        rescue
            nil
        end
    end

    def session_user
        User.find_by(id: decode_token)
    end

    def logged_in?
        !!session_user
    end

    def authorized
        render json: { errors: 'Please log in' }, status: :unauthorized unless logged_in?
    end
end
