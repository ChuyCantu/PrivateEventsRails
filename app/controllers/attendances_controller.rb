class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def enroll
    event = Event.find(params[:id])
    current_user.attended_events << event

    redirect_to(event_path(event))
  end

  def unenroll
    event = Event.find(params[:id])
    current_user.attended_events.delete(event)

    redirect_to(event_path(event))
  end
end
