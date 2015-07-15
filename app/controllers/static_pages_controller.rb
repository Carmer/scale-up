class StaticPagesController < ApplicationController
  def not_found
    redirect_to root_path
  end

  def index
    @next_events = Event.all.order("created_at desc").first(5)
    @just_added = Event.all.order("created_at desc").last(5)
  end
end
