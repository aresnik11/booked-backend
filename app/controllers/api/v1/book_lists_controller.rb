class Api::V1::BookListsController < ApplicationController
    def index
        book_lists = BookList.all
        render json: book_lists
    end

    def show
        book_list = BookList.find_by(id: params[:id])
        if book_list
            render json: book_list
        else
            render json: { errors: 'No book list found' }, status: :not_found
        end
    end
    
    def create
        book_list = BookList.new({name: book_list_params[:name], user: session_user})
        if book_list.save
            render json: book_list, status: :created
        else
            render json: { errors: book_list.errors.full_messages }, status: :not_acceptable
        end
    end

    private

    def book_list_params
        params.require(:book_list).permit(:name)
    end
end
