class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:create]

  # GET /bookings
  def index
    render json: current_user.bookings
  end

  # POST /bookings
  def create
    if !@event.hidden && @event.available_places.present? && @event.available_places > params[:count].to_i
      booking = create_booking
      render json: booking, status: :created
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:event_id])
  end

  # Only allow a trusted parameter "white list" through.
  def booking_params
    params.require(:booking).permit(:count)
  end

  def create_booking
    booking = Booking.new(booking_params)
    booking.event = @event
    booking.user = current_user

    @event.available_places -= booking.count

    Booking.transaction do
      @event.save
      booking.save
    end
    booking
  end
end
