class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    # search sur la destination et la date
    @events = policy_scope(Event).order(category: :desc)
    # search par localisation
    @events = @events.where("address ILIKE ?", "%#{params[:query][:city]}%") if params.dig(:query, :city) && params.dig(:query, :city) != ""
    # search par date
    if params.dig(:query, :start_date).present? && params.dig(:query, :start_date) != ""
      @events = @events.where("start_at >= ?", params[:query][:start_date]).where("start_at <= ?", params[:query][:end_date]).distinct.or(
        @events.where("end_at >= ?", params[:query][:start_date]).where("end_at <= ?", params[:query][:end_date]).distinct
      ).or(
        @events.where("start_at <= ?", params[:query][:start_date]).where("end_at >= ?", params[:query][:end_date]).distinct
      )
    end
    # search par category
    if params.dig(:query, :categories).present? && params.dig(:query, :categories) != [""]
      @events = @events.select { |event| !(event.category & params.dig(:query, :categories).reject(&:empty?)).empty? }
    end
    ids = @events.pluck(:id)
    @events = Event.where(id: ids)
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        color: $lavande,
        draggable: true,
        info_window: render_to_string(partial: "info_window", locals: {event: event}),
        image_url: helpers.asset_url("marqueur.png")
      }
    end
  end

  def show
    @event = Event.find(params[:id])
    authorize @event
    @booking = Booking.new
    @markers = [
      {
        lat: @event.latitude,
        lng: @event.longitude,
        color: $lavande,
        draggable: true,
        info_window: render_to_string(partial: "info_window", locals: {event: @event}),
        image_url: helpers.asset_url("marqueur.png")
      }
    ]
  end

  def new
    @user = current_user
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.category = params[:event][:category].reject(&:empty?)
    @event.user = current_user
    authorize @event
    if @event.save
      redirect_to event_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
    authorize @event
  end

  def update
    @event = Event.find(params[:id])
    @event.user = current_user
    authorize @event
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    authorize @event
    @event.destroy
    redirect_to events_path, status: :see_other
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :address, :phone_number,
      :price, :start_at, :end_at, :number_of_participants, :photo, :category)
  end
end
