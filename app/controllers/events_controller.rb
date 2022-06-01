class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    # params[:query][:city]
    @events = policy_scope(Event)
    # @events = policy_scope(Event).where(city: params[:query][:city])
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
