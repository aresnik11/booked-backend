require 'rest-client'
require 'json'
require 'dotenv/load'

API_KEY = ENV['GOOGLE_BOOKS_API_KEY']

class Api::V1::BooksController < ApplicationController
    def search
        #grabbing search term and search type from fetch headers
        search_term = request.headers["Search-Term"]
        search_type = request.headers["Search-Type"]
        #replace spaces with plus signs
        searchable_term = search_term.gsub(/\s/,'+')
        #get books with that search term
        #may want to add &filter=partial to not get dupes in All search - otherwise get results for viewability:"partial" and viewability:"no_pages"
        #format is q="search+term" for a search with that exact string
        #author/genre/title search format is q=intitle:"search+term" q=inauthor:"search+term" q=subject:"search+term"
        #search type is empty string if all, or the specific search format (i.e. intitle:)
        #langRestrict=en is restricting to only english books
        response_string = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=#{search_type}\"#{searchable_term}\"&langRestrict=en&maxResults=40&key=#{API_KEY}")
        response_hash = JSON.parse(response_string)
        #if there were 0 items found, send back an empty array of books
        if response_hash["totalItems"] == 0
            render json: {
                totalItems: response_hash["totalItems"],
                books: []
            }
        #send the books response back to the frontend in json
        # render json: response_hash
        #small thumbnail zoom=5
        #thumbnail zoom=1
        #small zoom=2
        #medium zoom=3
        #large zoom=4
        else
            renderBooks = response_hash["items"].map do |book|
                bookInfo = book["volumeInfo"]
                {
                    id: book["id"],
                    authors: bookInfo["authors"],
                    average_rating: bookInfo["averageRating"],
                    genres: bookInfo["categories"],
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
        end
    end
end
