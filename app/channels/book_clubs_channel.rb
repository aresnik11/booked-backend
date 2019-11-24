class BookClubsChannel < ApplicationCable::Channel
  def subscribed
    # everyone on the /bookclubs page
    stream_from "book_clubs_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
