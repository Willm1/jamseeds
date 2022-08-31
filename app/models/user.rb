class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_instruments
  has_many :user_genres
  has_many :messages
  has_many :instruments, through: :user_instruments
  has_many :genres, through: :user_genres
  has_many :instruments, through: :user_instruments


  def full_name
    "#{first_name} #{last_name}"
  end

  def age
    ((Time.zone.now - dob.to_time) / 1.year.seconds).floor
  end
end
