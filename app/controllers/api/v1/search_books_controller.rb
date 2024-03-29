require 'rest-client'
require 'json'
require 'dotenv/load'

API_KEY = ENV['GOOGLE_BOOKS_API_KEY']

class Api::V1::SearchBooksController < ApplicationController
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
        if response_hash["items"]
            renderBooks = response_hash["items"].map do |book|
                bookInfo = book["volumeInfo"]
                {
                    volume_id: book["id"],
                    author: bookInfo["authors"] ? bookInfo["authors"].join(", ") : false,
                    # author: bookInfo["authors"] ? bookInfo["authors"][0] : false,
                    average_rating: bookInfo["averageRating"],
                    description: bookInfo["description"],
                    #some books don't have the imageLinks hash within volumeInfo, need to check that it exists before grabbing the image
                    image: bookInfo["imageLinks"] ? bookInfo["imageLinks"]["thumbnail"] : "https://www.abbeville.com/assets/common/images/edition_placeholder.png",
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
end
