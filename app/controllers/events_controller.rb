class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    # search sur la destination
    @events = policy_scope(Event)
    @events = @events.where("address ILIKE ?", "%#{params[:query][:city]}%") if params.dig(:query, :city)
    if params.dig(:query, :start_date).present?
      @events = @events.where("start_at >= ?", params[:query][:start_date]).where("start_at <= ?", params[:query][:end_date]).distinct.or(
        @events.where("end_at >= ?", params[:query][:start_date]).where("end_at <= ?", params[:query][:end_date]).distinct
      ).or(
        @events.where("start_at <= ?", params[:query][:start_date]).where("end_at >= ?", params[:query][:end_date]).distinct
      )
    end
  end

  def show
    @event = Event.find(params[:id])
    authorize @event
  end

  def new
    @user = current_user
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
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
      :price, :start_at, :end_at, :number_of_participants, :photo)
  end
end
