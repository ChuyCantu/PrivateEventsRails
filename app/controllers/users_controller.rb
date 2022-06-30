class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    # today = today_zeroed
    # @my_events = current_user.events
    # @attending_events = current_user.attended_events.where("date >= ?", today)
    # @past_attended_events = current_user.attended_events.where("date < ?", today)
    @my_events = current_user.events
    @attending_events = current_user.attended_events.upcoming
    @past_attended_events = current_user.attended_events.past
  end

  # private

  # def today_zeroed
  #   today = DateTime.now
  #   today_zero = DateTime.new(today.year, today.month, today.day, 0, 0, 0)
  #   return today_zero
  # end
end
