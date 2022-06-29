class Event < ApplicationRecord
  belongs_to(:creator, class_name: "User")
  has_and_belongs_to_many(:attendees,
                          join_table: "attended_events",
                          foreign_key: "attended_event_id",
                          association_foreign_key: "attendee_id",
                          class_name: "User")

  validates(:title, presence: true)
  validates(:description, presence: true)
  validates(:date, presence: true)
  validates(:location, presence: true)
end
