class Book < ApplicationRecord
  has_many :book_list_books
  has_many :book_lists, through: :book_list_books
end
