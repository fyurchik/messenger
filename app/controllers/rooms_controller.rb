class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @rooms = Room.public_rooms
  end

  private

  def set_user
    @users = User.all_except(current_user)
  end
end
