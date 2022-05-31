class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    #@user = current_user
    @event = Event.new
    #authorize @user
  end

  def create
    @event = Event.new(event_params)
    #@buddy.user = current_user
    #authorize @buddy
    if @event.save
      redirect_to event_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :address, :phone_number,
      :price, :start_at, :end_at, :number_of_participants, :photo)
  end
end
