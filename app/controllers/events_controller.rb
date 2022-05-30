class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end
end
