class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  def index
    @users = policy_scope(User).all
  end

  def show
    @user = User.find(params[:id])
    authorize(@user)
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :postcode, :gender, :dob, :ability)
  end
end
