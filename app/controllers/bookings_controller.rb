class BookingsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @booking = Booking.new
    authorize @event
  end

  def create
    @booking = Booking.new(booking_param)
    @event = Event.find(params[:event_id])
    authorize @event
    @booking.event = @event
    @booking.user = current_user
    if @booking.save
      flash[:alert] = "Booking succes !!"
      redirect_to event_path(@event)
    else
      flash[:alert] = "Error, verify your information"
      render :new
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @bookings = Booking.all
    authorize @booking
    @event = @booking.event
    authorize @event
  end

  private

  def booking_param
    params.require(:booking).permit(:rating, :status, :reviews, :event_id, :user_id)
  end
end
