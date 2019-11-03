class BookListSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :books
end
