class ChatroomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chatroom = Chatroom.new
    @chatrooms = Chatroom.all

    @users = User.all_except(current_user)
    render 'index'
  end

  def show
    @single_room = Chatroom.find(params[:id])

    @chatroom = Chatroom.new
    @chatrooms = Chatroom.all

    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)

    @users = User.all_except(current_user)
    render 'index'
  end

  def create
    @chatroom = Chatroom.create(chatroom_params)
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:name)
  end
end
