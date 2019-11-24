class UserSerializer < ActiveModel::Serializer
  # only sends back these attributes, includes book list objects
  attributes :id, :username
  has_many :book_lists
end
