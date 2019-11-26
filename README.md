# Booked

Booked is a book app that allows users to search for books, add books to book lists, share book lists, and chat in online book clubs.

![Plant Nanny](https://user-images.githubusercontent.com/8761638/69591015-5bb54d00-0fbf-11ea-8bc3-47d08e74aac8.png)

## Demo

You can watch a live demo of the app [here](#) or visit the site at [https://booked.netlify.com](https://booked.netlify.com).

## Technology Used

* React
* Redux
* Websockets via ActionCable
* Google Books API
* Custom infinite scroll
* React Router
* Semantic UI
* Custom CSS
* JWT Authentication
* Ruby on Rails
* PostgreSQL database
* ActiveModel Serializer

The GitHub repo for the frontend can be found [here](https://github.com/aresnik11/booked-frontend).

## Features

Booked allows users to:

* Create an account
* Securely log in to an existing account
* Create a new book list
* Share a book list with another user
* Delete a book list
* Search for books by title, author, or genre - makes live calls to the Google Books API
* Automatically load next 40 books from search when user reaches the bottom of the page
* Click the back to top button to take the user back to the top of the search page
* Add a book to one of their book lists
* Remove a book from one of their book lists
* Create a new book club
* Chat with other users in real-time in a book club
* Delete a book club
* Securely log out
* Delete their account

## How To Use

Visit the site at [https://booked.netlify.com](https://booked.netlify.com).

To test on your own machine:
1. While logged into a Google account, go to [https://console.developers.google.com/apis/library/books.googleapis.com](https://console.developers.google.com/apis/library/books.googleapis.com) and click **Enable**
2. Follow the subsequent steps to generate an API key
3. Clone this repository
4. Switch to Ruby version `2.6.1`
5. Make sure `postgreSQL` is running on your computer, if not, download and run it
6. Create an `.env` file in the top level directory
7. In the `.env` file, create a constant variable `JWT_SECRET_KEY` and set it equal to whatever you want your secret key to be. Ex: `JWT_SECRET_KEY=test123`
8. In the `.env` file, create a constant variable `GOOGLE_BOOKS_API_KEY` and set it equal to your API key
9. In terminal run `bundle install`
10. In terminal run `rails db:migrate`
11. In terminal run `rails s` to start the Rails server
12. Follow instructions [here](https://github.com/aresnik11/booked-frontend) to run the frontend
13. You will need to update `config/initializers/cors.rb` to accept origin requests from wherever your frontend will be hosted

## Enjoy!
