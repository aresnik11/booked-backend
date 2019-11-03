class Api::V1::BookListBooksController < ApplicationController
    #may want to show a specific error if this book is already on the book list?
    def create
        book_list_book = BookListBook.find_or_create_by(book_list_book_params)
        if book_list_book.valid?
            render json: book_list_book
        else
            render json: { errors: book_list_book.errors.full_messages }, status: :not_acceptable
        end
    end

    private

    def book_list_book_params
        params.require(:book_list_book).permit(:book_id, :book_list_id)
    end
end
