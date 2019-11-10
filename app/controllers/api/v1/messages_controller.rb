class Api::V1::MessagesController < ApplicationController
    def create
        message = Message.new({
            content: message_params[:content],
            book_club_id: message_params[:book_club_id],
            user: session_user
        })
        if message.save
            MessagesChannel.broadcast_to(message.book_club, { type: "RECEIVE_MESSAGE", payload: MessageSerializer.new(message) })
            render json: message, status: :created
        else
            render json: { errors: message.errors.full_messages }, status: :not_acceptable
        end
    end

    private

    def message_params
        params.require(:message).permit(:book_club_id, :content)
    end
end
