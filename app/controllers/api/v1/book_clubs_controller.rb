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
            render json: book_club, status: :created
        else
            render json: { errors: book_club.errors.full_book_clubs }, status: :not_acceptable
        end
    end

    def destroy
        book_club = BookClub.find_by(id: params[:id])
        if book_club
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