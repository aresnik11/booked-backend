class Message < ApplicationRecord
  belongs_to :user
  belongs_to :book_club
  
  validates :content, presence: true
end
