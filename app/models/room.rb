class Room < ApplicationRecord
  validates_uniqueness_of :name
  has_many :user_rooms, dependent: :destroy
  scope :public_rooms, -> {where(is_private: false)}
  after_create_commit {broadcast_if_public}
  has_many :messages

  def broadcast_if_public
    if is_private == false
      broadcast_append_to "rooms" 
    end
  end

  def other_participant(current_user)
    user_rooms.where.not(user_id: current_user.id).first&.user
  end

  def self.create_private(users, name)
   single_room = Room.create(name: name, is_private: true)
    users.each do |user|
      single_room.user_rooms.create(user: user, room: single_room)
    end
    single_room
  end
end
