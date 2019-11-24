class Api::V1::MessagesController < ApplicationController
    def create
        # create a new message with content and book club id from params and user as the current session user
        message = Message.new({
            content: message_params[:content],
            book_club_id: message_params[:book_club_id],
            user: session_user
        })
        if message.save
            # broadcast to everyone in a specific book club channel that a new message was added
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
