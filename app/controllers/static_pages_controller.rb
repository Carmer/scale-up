class StaticPagesController < ApplicationController
  def not_found
    redirect_to root_path
  end

  def index
    @next_events = Event.all.first(5)
    @just_added = Event.all.last(2)
  end
end
