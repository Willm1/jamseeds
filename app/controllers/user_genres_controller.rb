class UserGenresController < ApplicationController
  def new
    @user_genre = UserGenre.new(user: current_user)
    authorize(@user_genre)
  end

  def create
    @user_genre = UserGenre.new(user_genre_params)
    @user_genre.user = current_user
    authorize(@user_genre)
    if @user_genre.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  private

  def user_genre_params
    params.require(:user_genre).permit(:genre_id)
  end
end
