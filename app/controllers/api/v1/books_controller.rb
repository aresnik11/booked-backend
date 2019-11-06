require 'rest-client'
require 'json'
require 'dotenv/load'

API_KEY = ENV['GOOGLE_BOOKS_API_KEY']

class Api::V1::BooksController < ApplicationController
    # def index
    #     books = Book.all
    #     render json: books
    # end

    # def show
    #     book = Book.find_by(id: params[:id])
    #     if book
    #         render json: book
    #     else
    #         render json: { errors: 'No book found' }, status: :not_found
    #     end
    # end

    def create
        book = Book.find_or_create_by(book_params)
        if book.valid?
            render json: book
        else
            render json: { errors: book.errors.full_messages }, status: :not_acceptable
        end
    end
    
    def search
        #grabbing search term and search type from fetch headers
        search_term = request.headers["Search-Term"]
        search_type = request.headers["Search-Type"]
        start_index = request.headers["Start-Index"].to_i
        #replace spaces with plus signs
        searchable_term = search_term.gsub(/\s/,'+')
        #get books with that search term
        #format is q="search+term" for a search with that exact string
        #-"free+preview" is to exclude free preview books
        #author/genre/title search format is q=intitle:"search+term" q=inauthor:"search+term" q=subject:"search+term"
        #search type is empty string if all, or the specific search format (i.e. intitle:)
        #langRestrict=en is restricting to only english books
        #&filter=partial to not get dupes in All search - otherwise get results for viewability:"partial" and viewability:"no_pages"
        response_string = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=-\"free+preview\"#{search_type}\"#{searchable_term}\"&langRestrict=en&filter=partial&maxResults=40&startIndex=#{start_index}&key=#{API_KEY}")
        response_hash = JSON.parse(response_string)
        #send the books response back to the frontend in json
        #small thumbnail zoom=5
        #thumbnail zoom=1
        #small zoom=2
        #medium zoom=3
        #large zoom=4
        if response_hash["items"]
            renderBooks = response_hash["items"].map do |book|
                bookInfo = book["volumeInfo"]
                {
                    volume_id: book["id"],
                    author: bookInfo["authors"] ? bookInfo["authors"][0] : false,
                    average_rating: bookInfo["averageRating"],
                    description: bookInfo["description"],
                    #some books don't have the imageLinks hash within volumeInfo, need to check that it exists before grabbing the image
                    image: bookInfo["imageLinks"] ? bookInfo["imageLinks"]["thumbnail"] : false,
                    url: bookInfo["previewLink"],
                    page_count: bookInfo["pageCount"],
                    published_date: bookInfo["publishedDate"],
                    publisher: bookInfo["publisher"],
                    title: bookInfo["title"],
                    subtitle: bookInfo["subtitle"]
                }
            end
            render json: {
                totalItems: response_hash["totalItems"],
                books: renderBooks
            }
        #if there were 0 items found, send back an empty array of books
        else
            render json: {
                totalItems: response_hash["totalItems"],
                books: []
            }
        end
    end

    private

    def book_params
        params.require(:book).permit(:title, :publisher, :published_date, :average_rating, :page_count, :image, :description, :url, :author, :subtitle, :volume_id)
    end
end