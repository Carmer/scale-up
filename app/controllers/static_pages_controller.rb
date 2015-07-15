class StaticPagesController < ApplicationController
  def not_found
    redirect_to root_path
  end

  def index
    @events = Event.first(20)
  end
end
