class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Don't display current user in chatroom
  scope :all_except, ->(user) { where.not(id: user) }
  # Automatically add user to chatroom when they join
  after_create_commit { broadcast_append_to 'users' }

  has_many :user_instruments
  has_many :user_genres
  has_many :messages
  has_many :instruments, through: :user_instruments
  has_many :genres, through: :user_genres
  has_many :chatroom_users
end
