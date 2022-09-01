class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  scope :public_rooms, -> { where(group: true) }
  after_create_commit { broadcast_append_to 'chatrooms' }
end
