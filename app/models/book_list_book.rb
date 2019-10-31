class BookListBook < ApplicationRecord
  belongs_to :book
  belongs_to :book_list
end
