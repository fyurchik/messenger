class MessagesController < ApplicationController
  def create
    @message = current_user.messages.create(body: message_params[:body], room_id: params[:room_id], image: message_params[:image])
    redirect_to room_path(@message.room_id)
  end

  private

  def message_params
    params.require(:message).permit(:body, :image)
  end
end
