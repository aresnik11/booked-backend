class BookListSerializer < ActiveModel::Serializer
  # only sends back these attributes, includes book objects
  attributes :id, :name, :books
end
