class VenuesController < ApplicationController
  def show
    @venue = Venue.find_by(id: params[:id]).paginate(:page => params[:page], :per_page => 30)
    @items = Item.active.not_in_cart(session[:cart]).joins(:event).where(events: {venue_id: @venue.id}).paginate(:page => params[:page], :per_page => 30)
    @events = @items.events.paginate(:page => params[:page], :per_page => 30)
  end
end
