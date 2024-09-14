class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[index]

  def index
    @room = Room.new
  end

  def create
    @room = Room.create(room_params)
  end

  private

  def room_params
    params.require(:room).permit(:name, :is_private)
  end

  def set_user
    @rooms = Room.public_rooms
    @users = User.all_except(current_user)
  end
end
