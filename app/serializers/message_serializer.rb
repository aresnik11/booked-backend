class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :user, :book_club_id

  def user
    UserSerializer.new(object.user).attributes
  end
end
