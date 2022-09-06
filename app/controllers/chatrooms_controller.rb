class ChatroomsController < ApplicationController
  before_action :authenticate_user!

  def index
    skip_policy_scope
    @chatroom = Chatroom.new
    @chatrooms = Chatroom.all
    @user = ChatroomUser.where(chatroom_id: current_user.chatroom_users.first.chatroom_id).last.user
    @users = User.all_except(current_user)
  end

  def show
    skip_authorization
    @single_room = Chatroom.find(params[:id])

    @chatroom = Chatroom.new
    @chatrooms = Chatroom.all

    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)

    @users = User.all_except(current_user)
    # start_chat_path(id: @user.id)

    render 'index'
  end

  def create
    skip_authorization
    @chatroom = Chatroom.create(chatroom_params)
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:name)
  end
end
