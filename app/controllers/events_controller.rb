class EventsController < ApplicationController
  def index
    @items  = Item.active.paginate(:page => params[:page], :per_page => 10)

    if params[:category]
      @events = Event.where(category: Category.find_by!(name: params[:category])).paginate(:page => params[:page], :per_page => 10)
    else
      @events = Event.all.paginate(:page => params[:page], :per_page => 10)
    end

  end

  def show
    @event = Event.find_by(id: params[:id])
    @items = @event.items.active.not_in_cart(session[:cart]).paginate(:page => params[:page], :per_page => 10) if params[:category]
  end

  def random
    if Event.count > 1
      offset = rand(1..20000)
      event = Event.find_by!(id: offset)
      redirect_to event
    else
      redirect_to root_path
    end
  end
end
