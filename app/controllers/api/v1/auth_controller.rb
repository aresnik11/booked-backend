class Api::V1::AuthController < ApplicationController
    skip_before_action :authorized, only: [:login]

    def login
        user = User.find_by(username: user_login_params[:username])
        if user && user.authenticate(user_login_params[:password])
          token = encode_token(user.id)
          render json: { user: UserSerializer.new(user), token: token }
        else
          render json: { errors: "Invalid username or password" }, status: :unauthorized
        end
    end
    
    def auto_login
        render json: { user: UserSerializer.new(session_user) }
    end

    private

    def user_login_params
        params.require(:user).permit(:username, :password)
    end
end
