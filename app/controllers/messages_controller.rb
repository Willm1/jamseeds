class MessagesController < ApplicationController
  def create
    @message = current_user.messages.create(content: message_params[:content], chatroom_id: params[:chatroom_id])
    skip_authorization
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
