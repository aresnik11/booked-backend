class Api::V1::UsersController < ApplicationController
    # not requiring user to be authorized to create an account
    skip_before_action :authorized, only: [:create]
    
    def index
        users = User.all
        render json: users
    end

    def create
        user = User.new(user_params)
        # if the new user is valid
        if user.save
            #automatically create default booklists on creation of a new user
            BookList.create({name: "Favorites", user: user})
            BookList.create({name: "Read", user: user})
            BookList.create({name: "Want to read", user: user})
            # encode the user id (function in application controller)
            token = encode_token(user.id)
            # send back a serialized user with the token
            render json: { user: UserSerializer.new(user), token: token }, status: :created
        # otherwise send back the error
        else
            render json: { errors: user.errors.full_messages }, status: :not_acceptable
        end
    end

    # deletes session users account
    def destroy
        session_user.destroy
        render json: session_user
    end
    
    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
