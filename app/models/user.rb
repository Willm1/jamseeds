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
  has_many :instruments, through: :user_instruments

  has_one_attached :photo
  has_one_attached :background



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
      return "Intermediate"
    elsif ability == 2
      return "Advanced"
    elsif ability == 3
      return "Expert"
    end
  end

  def updated_gender
    return if gender.blank?

    if gender == 0
      return "Female"
    elsif gender == 1
      return "Male"
    elsif gender == 2
      return "Non-binary"
    elsif gender == 3
      return "Prefer not to say"
    end
  end

  def online?
    return if last_login_at.nil?

    last_login_at > 30.minutes.ago
  end
end
