class BookClubSerializer < ActiveModel::Serializer
  # only sends back these attributes, includes message objects
  attributes :id, :name
  has_many :messages

  # sorts message by created at date/time so messages appear in order
  def messages
    object.messages.sort_by do |message|
      message.created_at
    end
  end
end
