class UserSerializer < ActiveModel::Serializer
  attributes :id, :username
  has_many :book_lists
  has_many :authors
end
