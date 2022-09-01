class ChatroomsController < ApplicationController
  before_action :authenticate_user!, :load_entities

end
