class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home css_template]

  def home
  end

  def css_template
  end
end
