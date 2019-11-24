class MessagesChannel < ApplicationCable::Channel
  def subscribed
    # everyone on a specific book club page - /bookclubs/:id
    book_club = BookClub.find_by(id: params[:book_club_id])
    stream_for book_club
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
