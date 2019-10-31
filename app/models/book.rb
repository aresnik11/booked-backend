class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre
  has_many :book_list_books
  has_many :book_lists, through: :book_list_books
end
