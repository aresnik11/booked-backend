class User < ApplicationRecord
    has_many :book_lists
    has_many :favorite_authors
    has_many :authors, through: :favorite_authors
    has_secure_password
end
