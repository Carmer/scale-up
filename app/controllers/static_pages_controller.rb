class StaticPagesController < ApplicationController
  def not_found
    redirect_to root_path
  end

  def index
    @events = Event.first(5)
  end
end
