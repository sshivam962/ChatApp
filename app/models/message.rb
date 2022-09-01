class Message < ApplicationRecord
  validates_presence_of :body, :conversation_id, :user_id

  # Used to calculate date and time of message
  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end

end
