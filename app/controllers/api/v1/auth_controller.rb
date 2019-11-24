class Api::V1::AuthController < ApplicationController
    # not requiring user to be authorized to log into their account or demo account
    skip_before_action :authorized, only: [:login, :demo_login]

    def login
        user = User.find_by(username: user_login_params[:username])
        # if user exists and the inputted password matches their password (bcrypt)
        if user && user.authenticate(user_login_params[:password])
            # encode the user id (function in application controller)
            token = encode_token(user.id)
            # send back a serialized user with the token
            render json: { user: UserSerializer.new(user), token: token }
        # otherwise send back error
        else
            render json: { errors: "Invalid username or password" }, status: :unauthorized
        end
    end

    def demo_login
        # find the demo account
        user = User.find_by(username: "demo")
        if user
            # encode the user id (function in application controller)
            token = encode_token(user.id)
            # send back a serialized user with the token
            render json: { user: UserSerializer.new(user), token: token }
        else
            render json: { errors: "Unable to log in" }, status: :unauthorized
        end
    end
    
    # using authorized before_action, so only sending back serialized session user if authorized
    def auto_login
        render json: { user: UserSerializer.new(session_user) }
    end

    private

    def user_login_params
        params.require(:user).permit(:username, :password)
    end
end
