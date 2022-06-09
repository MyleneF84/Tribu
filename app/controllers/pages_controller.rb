class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @last_events = Event.all.last(4)
  end

  def dashboard
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
