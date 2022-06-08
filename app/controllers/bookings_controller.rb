class BookingsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @booking = Booking.new
    authorize @event
  end

  def create
    @event = Event.find(params[:event_id])
    authorize @event
    @booking = Booking.new
    @booking.event = @event
    @booking.status = "en-attente"
    @booking.user = current_user
    if @booking.save
      flash[:notice] = "Booking success !!"
      redirect_to dashboard_path
    else
      flash[:alert] = "Error, verify your information"
      render 'events/show', status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @bookings = Booking.all
    authorize @booking
    @event = @booking.event
    authorize @event
  end

  def update
    @booking = Booking.find(params[:id])
    @event = @booking.event
    @booking.update(booking_param)
  end

  def accept
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.update(status: "accepted")
    #@event = @booking.event
    #authorize @event
    flash[:notice] = "Demande acceptée!"
    redirect_to dashboard_path(@booking.event)
  end

  def decline
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.update(status: "declined")
    #@event = @booking.event
    #authorize @event
    flash[:alert] = "Demande rejetée!"
    redirect_to dashboard_path(@booking.event)
  end

  private

  def booking_param
    params.require(:booking).permit(:rating, :status, :reviews)
  end
end
