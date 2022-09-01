class MessagesController < ApplicationController
  before_action :authorize
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @users = User.all
    @messages = @conversation.messages
  end

  def new
    @message =Message.new
  end
  # Create a new message and broadcast to the chat channel using action cable
  def create
    @messages = @conversation.messages
      @message = @conversation.messages.new(message_params)
    respond_to do |f|
      f.js{@message.save!}
    end

      ActionCable.server.broadcast("chat", { body: render_message(@message), id: @message.id })
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
  # Render message and broadcast to the channel as body.
  def render_message(message)
    user = User.find(message.user_id)
    render partial: 'message', locals: {message: message, user: user, id: message.id}
  end
end
