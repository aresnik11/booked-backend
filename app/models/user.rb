class User < ApplicationRecord
    has_many :book_lists, dependent: :destroy
    has_many :messages, dependent: :destroy
    has_many :book_clubs, through: :messages
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }
    validates :username, :password, presence: true
end
