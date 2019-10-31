class Author < ApplicationRecord
    has_many :books
    has_many :genres, through: :books
    has_many :favorite_authors
    has_many :users, through: :favorite_authors
end
