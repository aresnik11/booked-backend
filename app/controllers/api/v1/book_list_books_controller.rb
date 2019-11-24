class Api::V1::BookListBooksController < ApplicationController
    def create
        #if the book is already on the book list, don't want to add it again
        if BookListBook.find_by(book_list_book_params)
            render json: { errors: ['Book already on book list'] }, status: :not_acceptable
        else
            book_list_book = BookListBook.new(book_list_book_params)
            if book_list_book.save
                render json: book_list_book
            else
                render json: { errors: book_list_book.errors.full_messages }, status: :not_acceptable
            end
        end
    end

    def destroy
        # finds the book list book by book id and book list id
        book_list_book = BookListBook.find_by(book_list_book_params)
        if book_list_book
            book_list_book.destroy
            render json: book_list_book
        else
            render json: { errors: 'No book list book found' }, status: :not_found
        end
    end

    private

    def book_list_book_params
        params.require(:book_list_book).permit(:book_id, :book_list_id)
    end
end
