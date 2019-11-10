class MessagesChannel < ApplicationCable::Channel
  def subscribed
    book_club = BookClub.find_by(id: params[:book_club_id])
    stream_for book_club
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
