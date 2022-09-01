class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  def index
    # @users = policy_scope(User).where.not(id: current_user)
    @users = policy_scope(User).all

  end

  def show
    @user = User.find(params[:id])
    authorize(@user)
  end

  def edit
    @user = User.find(params[:id])
    authorize(@user)
  end

  def update
    @user = User.find(params[:id])
    authorize(@user)
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :postcode, :gender, :dob, :ability, :city)
  end
end
