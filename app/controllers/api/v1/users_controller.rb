class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
    def index
        users = User.all
        render json: users
    end

    def create
        user = User.new(user_params)
        if user.save
            #automatically create default booklists on creation of a new user
            BookList.create({name: "Favorites", user: user})
            BookList.create({name: "Read", user: user})
            BookList.create({name: "Want to read", user: user})
            # BookList.create({name: "Shared with me", user: user})

            token = encode_token(user.id)
            render json: { user: UserSerializer.new(user), token: token }, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :not_acceptable
        end
    end

    def destroy
        session_user.destroy
        render json: session_user
    end
    
    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
