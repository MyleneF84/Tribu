class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @last_events = Event.all.last(3)
  end

  def dashboard
    @created_events = current_user.events
    @participating_events = current_user.participating_events
  end
end
