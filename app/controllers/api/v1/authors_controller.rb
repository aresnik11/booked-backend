class Api::V1::AuthorsController < ApplicationController
    def show
        author = Author.find_by(id: params[:id])
        if author
            render json: author
        else
            render json: { message: 'No author found' }, status: :not_found
        end
    end
end
