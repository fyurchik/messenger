class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  after_create_commit { broadcast_append_to room }

  before_create :confirm_participant

  def confirm_participant
    return unless room.is_private
    is_participant = room.user_rooms.where(user_id: user.id).exists?
    throw(:abort) unless is_participant
  end
end
