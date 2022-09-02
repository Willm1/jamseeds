class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  def index
    if params[:query].present?
      sql_query = "city ILIKE :query"
      @users = policy_scope(User).where(sql_query, query: "%#{params[:query]}%").where.not(id: current_user)
    else
      @users = policy_scope(User).where.not(id: current_user)
      # @users = policy_scope(User).all
    end
  end

  def show
    @user = User.find(params[:id])
    authorize(@user)
  end

  def chatroom
    @user = User.find(params[:id])
    skip_authorization
    @users = User.all_except(current_user)

    @chatroom = Chatroom.new
    @chatrooms = Chatroom.all
    @chatroom_name = get_name(@user, current_user)
    @single_room = Chatroom.where(name: @chatroom_name).first ||
                   Chatroom.create_private_room([@user, current_user], @chatroom_name)

    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)

    render 'chatrooms/index'
   end

  def edit
    @user = User.find(params[:id])
    authorize(@user)
  end

  def update
    @user = User.find(params[:id])

    authorize(@user)

    if @user.update(user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def my_profile
    @user = current_user
    skip_authorization
  end

  private

  def get_name(user1, user2)
    user = [user1, user2].sort
    "private_#{user[0].id}_#{user[1].id}"
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :postcode, :gender, :dob, :ability, :city, :photo)
  end
end
