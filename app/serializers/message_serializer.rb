class MessageSerializer < ActiveModel::Serializer
  # only sends back these attributes, includes user object
  attributes :id, :content, :created_at, :user, :book_club_id

  # serializing the user object we are sending back with each message
  def user
    UserSerializer.new(object.user).attributes
  end
end
