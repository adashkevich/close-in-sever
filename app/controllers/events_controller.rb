class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :update, :destroy, :book]

  # GET /events
  def index
    @events = Event.within(params[:area], params[:date]).where(hidden: false)

    render json: @events
  end

  # GET /events/1
  # def show
  #   render json: @event
  # end

  # POST /events
  def create
    @event = Event.new(event_params)
    @event.organizer = current_user

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
  end

  # GET /events/participate
  def participate
    render json: current_user.events.where('start_time > ?', Time.new).order(:start_time)
  end

  # GET /events/organize
  def organize
    render json: current_user.organizing_events.where('end_time > ?', Date.yesterday).order(:start_time)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def event_params
    params.require(:event).permit(:title, :category, :location, :hidden, :start_time, :end_time, :cost, :capacity)
  end
end
