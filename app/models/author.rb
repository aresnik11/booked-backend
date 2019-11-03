class Author < ApplicationRecord
    has_many :favorite_authors
    has_many :users, through: :favorite_authors
end
