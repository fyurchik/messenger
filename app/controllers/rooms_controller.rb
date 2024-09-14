class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:index, :show]
  before_action :set_users, only: [:index, :show]
  before_action :set_rooms, only: [:index, :show]

  def index
    render :index
  end

  def show
    @single_room = Room.find(params[:id])
    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)
    render :index
  end

  def create
    @room = Room.create(room_params)
  end

  private

  def room_params
    params.require(:room).permit(:name, :is_private)
  end

  def set_users
    @users = User.all_except(current_user)
  end

  def set_rooms
    @rooms = Room.public_rooms
  end

  def set_room
    @room = Room.new
  end
end
