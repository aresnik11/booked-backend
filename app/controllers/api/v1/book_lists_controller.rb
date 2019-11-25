class Api::V1::BookListsController < ApplicationController
    def create
        # create a new book list with the name inputted and the user as the session user
        book_list = BookList.new({name: book_list_params[:name], user: session_user})
        if book_list.save
            render json: book_list, status: :created
        else
            render json: { errors: book_list.errors.full_messages }, status: :not_acceptable
        end
    end

    def destroy
        book_list = BookList.find_by(id: params[:id])
        if book_list
            book_list.destroy
            render json: book_list
        else
            render json: { errors: 'No book list found' }, status: :not_found
        end
    end

    def share
        #find book list passed in params
        shared_book_list = BookList.find_by(id: params[:book_list_id])
        if shared_book_list
            # if shared book list already has "Shared from" in name, don't want to add it again
            if shared_book_list.name.include?("Shared from")
                # format will be "Shared from amy - favorites", splitting on " - " and grabbing second element from array
                book_list_name = shared_book_list.name.split(" - ")[1]
                book_list = BookList.new({name: "Shared from #{session_user.username} - #{book_list_name}", user_id: params[:user_id]})
            else
                #create a new booklist with the same name as shared book list, but for the user that we want to share with (from params)
                book_list = BookList.new({name: "Shared from #{session_user.username} - #{shared_book_list.name}", user_id: params[:user_id]})
            end
            if book_list.save
                #create booklist books for each book in the shared book list for our new book list
                shared_book_list.books.each do |book|
                    BookListBook.create(book_id: book.id, book_list_id: book_list.id)
                end
                render json: book_list
            else
                render json: { errors: book_list.errors.full_messages }, status: :not_acceptable
            end
        else
            render json: { errors: 'No book list found' }, status: :not_found
        end
    end

    private

    def book_list_params
        params.require(:book_list).permit(:name)
    end
end
