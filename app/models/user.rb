class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :jwt_authenticatable, :registerable,
         jwt_revocation_strategy: JWTBlacklist

  validates :phone, uniqueness: { scope: :country_code, message: 'User with this phone is already registered' }

  has_many :organizing_events, foreign_key: 'organizer_id', class_name: 'Event'



  has_many :bookings
  has_many :events, through: :bookings
  accepts_nested_attributes_for :bookings
  #has_and_belongs_to_many :participating_events, class_name: 'Event'
end