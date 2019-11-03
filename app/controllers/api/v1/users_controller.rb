class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def show
        user = User.find_by(id: params[:id])
        if user
            render json: user
        else
            render json: { errors: 'No user found' }, status: :not_found
        end
    end

    def create
        user = User.new(user_params)
        if user.save
            token = encode_token(user.id)
            render json: { user: UserSerializer.new(user), token: token }, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :not_acceptable
        end
    end
    
    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
