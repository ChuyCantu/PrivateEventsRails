class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    today = today_zeroed
    @upcoming_events = Event.all.where("date >= ?", today)
    @past_events = Event.all.where("date < ?", today)
  end

  def show
    @event = Event.find(params[:id])
    @attendees = @event.attendees
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to(root_path)
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to(root_path)
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :location)
  end

  def today_zeroed
    today = DateTime.now
    today_zero = DateTime.new(today.year, today.month, today.day, 0, 0, 0)
    return today_zero
  end
end
