class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @last_events = Event.all.last(4)
  end

  def index
    start_date = params.fetch(:start_date, Date.today).to_date
    @events = Event.where(starts_at: start_date.beginning_of_week..start_date.end_of_week)
  end

  def dashboard
    start_date = params.fetch(:start_at, Date.today).to_date
    @events = Event.where(start_at: start_date.beginning_of_week..start_date.end_of_week)
    @created_events = current_user.events
    @participating_events = current_user.participating_events
    @markers = @participating_events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        color: $lavande,
        draggable: true,
        info_window: render_to_string(partial: "events/info_window", locals: {event: event}),
        image_url: helpers.asset_url("marqueur.png")
      }
    end
  end
end
