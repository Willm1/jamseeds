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
      redirect_to profile_path
    else
      render :new
    end
  end

  def destroy
    @user_genre = UserGenre.find(params[:id])
    authorize(@user_genre)
    @user_genre.destroy
    redirect_to profile_path
  end

  private

  def user_genre_params
    params.require(:user_genre).permit(:genre_id)
  end
end
