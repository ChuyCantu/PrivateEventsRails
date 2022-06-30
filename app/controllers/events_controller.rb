class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    today = today_zeroed
    @upcoming_events = Event.where("date >= ?", today)
    @past_events = Event.where("date < ?", today)
  end

  def show
    @event = Event.find(params[:id])
    @attendees = @event.attendees
  end

  def new
    @event = current_user.events.build
    # @event.date = Time.now
    # TODO: Handle time zones
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      flash[:notice] = "Event successfully created"
      redirect_to(root_path)
    else
      flash[:alert] = "Failed to create event"
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      flash[:notice] = "Event successfully updated"
      redirect_to(root_path)
    else
      flash[:alert] = "Failed to update event"
      render(:new, status: :unprocessable_entity)
    end
  end

  def destroy
    @event = Event.find(params[:id])

    if @event.creator == current_user
      @event.destroy
      flash[:notice] = "Event successfully deleted"
    else
      flash[:alert] = "Cannot delete other's user events"
    end

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
