class Api::V1::BooksController < ApplicationController
    def create
        book = Book.find_or_create_by(book_params)
        if book.valid?
            render json: book
        else
            render json: { errors: book.errors.full_messages }, status: :not_acceptable
        end
    end

    def show
        #see if we can find the book via id (if came from booklist page)
        book = Book.find_by(id: params[:id])
        if book
            render json: book
        else
            render json: { errors: 'No book found' }, status: :not_found
        end
    end

    def find_by_volume
        #see if we can find the book via volume_id (if came from the search page)
        book = Book.find_by(volume_id: params[:id])
        if book
            render json: book
        #otherwise, just send back the volume_id to look through the array of searched books
        else
            render json: { volume_id: params[:id] }
        end
    end

    private

    def book_params
        params.require(:book).permit(:title, :publisher, :published_date, :average_rating, :page_count, :image, :description, :url, :author, :subtitle, :volume_id)
    end
end