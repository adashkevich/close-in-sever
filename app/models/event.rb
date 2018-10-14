class Event < ApplicationRecord

  belongs_to :organizer, class_name: 'User'

  has_many :bookings
  has_many :users, through: :bookings
  accepts_nested_attributes_for :bookings, allow_destroy: true
  #has_and_belongs_to_many :participants, class_name: 'User'

  before_create :default_values

  scope :within, ->(area, date) {
    where("ST_Intersects(location, #{area}) AND start_time::date = '#{date}'::date")
  }

  def available_places=(value)
    super(value)
    write_attribute(:hidden, true) if value.zero?
  end

  def default_values
    self.available_places = capacity if capacity.present? && !available_places.present?
  end
end
