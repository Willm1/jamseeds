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


  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :city ],
    using: {
      tsearch: { prefix: true }
    }

  # pg_search_scope :global_search,
  #   against: [:city],
  #   associated_against: {
  #     instrument: [:name]
  #   },
  #   using: {
  #     tsearch: { prefix: true }
  #   }

  def full_name
    return if first_name.blank?

    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def age
    return if dob.blank?
    ((Time.zone.now - dob.to_time) / 1.year.seconds).floor
  end

  def updated_ability
    return if ability.blank?

    if ability == 0
      return "Beginner"
    elsif ability == 1
      return "intermediate"
    elsif ability == 2
      return "Advanced"
    elsif ability == 3
      return "Expert"
    end
  end
end
