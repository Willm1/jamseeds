class UserInstrumentsController < ApplicationController
  def new
    @user_instrument = UserInstrument.new(user: current_user)
    authorize(@user_instrument)
  end

  def create
    @user_instrument = UserInstrument.new(user_instrument_params)
    @user_instrument.user = current_user
    authorize(@user_instrument)
    if @user_instrument.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def destroy
    @user_instrument = UserInstrument.find(params[:id])

    authorize(@user_instrument)

    @user_instrument.destroy

    redirect_to user_path(current_user)
  end

  private

  def user_instrument_params
    params.require(:user_instrument).permit(:instrument_id)
  end
end
