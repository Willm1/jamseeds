class Chatroom < ApplicationRecord
  scope :public_rooms, -> { where(group: true) }
  after_create_commit { broadcast_if_public }
  has_many :messages, dependent: :destroy
  has_many :chatroom_users, dependent: :destroy

  def broadcast_if_public
    broadcast_append_to 'rooms' if group
  end

  def self.create_private_room(users, room_name)
    single_room = Chatroom.create(name: room_name, group: false)

    users.each do |user|

    end
  end
end
