class BookList < ApplicationRecord
  belongs_to :user
  has_many :book_list_books
  has_many :books, through: :book_list_books
  validates :name, presence: true
end
