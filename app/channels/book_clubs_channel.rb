class BookClubsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "book_clubs_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
