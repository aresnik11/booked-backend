class Api::V1::BookClubsController < ApplicationController
    def index
        book_clubs = BookClub.all
        render json: book_clubs
    end

    def show
        book_club = BookClub.find_by(id: params[:id])
        if book_club
            render json: book_club
        else
            render json: { errors: 'No book club found' }, status: :not_found
        end
    end

    def create
        book_club = BookClub.new(book_club_params)
        if book_club.save
            # broadcast to everyone in the book clubs channel that a new book club was added
            ActionCable.server.broadcast("book_clubs_channel", { type: "ADD_BOOK_CLUB", payload: BookClubSerializer.new(book_club) })
            render json: book_club, status: :created
        else
            render json: { errors: book_club.errors.full_messages }, status: :not_acceptable
        end
    end

    def destroy
        book_club = BookClub.find_by(id: params[:id])
        if book_club
            # broadcast to everyone in the book clubs channel that a book club was removed
            ActionCable.server.broadcast("book_clubs_channel", { type: "REMOVE_BOOK_CLUB", payload: BookClubSerializer.new(book_club) })
            book_club.destroy
            render json: book_club
        else
            render json: { errors: 'No book club found' }, status: :not_found
        end
    end

    private

    def book_club_params
        params.require(:book_club).permit(:name)
    end
end
