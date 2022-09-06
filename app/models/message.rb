class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom
  after_create_commit :broadcast_message_to_chatroom

  before_create :confirm_participant

  def confirm_participant
    return if chatroom.group
    # raise
    is_participant = ChatroomUser.find_by(user_id: user.id, chatroom_id: chatroom.id)
    throw :abort unless is_participant
  end

  def broadcast_message_to_chatroom
    return nil unless current_user
    broadcast_append_to(chatroom, locals: { user: current_user })
  end
end
