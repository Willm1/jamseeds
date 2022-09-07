class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home css_template]

  def home
    redirect_to users_path if user_signed_in?
    @users = User.all.last(4)
  end

  
end
