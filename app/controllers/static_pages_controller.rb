class StaticPagesController < ApplicationController
  def not_found
    redirect_to root_path
  end

  def index
    @next_events = Event.first(5)
    @just_added = Event.last(2)
  end
end
