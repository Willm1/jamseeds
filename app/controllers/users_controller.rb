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

  def user_params
    params.require(:user).permit(:first_name, :last_name, :postcode, :gender, :dob, :ability, :city, :photo)
  end
end
