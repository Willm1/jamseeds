class Instrument < ApplicationRecord
  has_many :user_instruments, dependent: :destroy
  has_many :users, through: :user_instruments
end
