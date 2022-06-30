class Event < ApplicationRecord
  belongs_to(:creator, class_name: "User")
  has_and_belongs_to_many(:attendees,
                          join_table: "attended_events",
                          foreign_key: "attended_event_id",
                          association_foreign_key: "attendee_id",
                          class_name: "User")
  before_destroy { attendees.clear }

  validates(:title, presence: true)
  validates(:description, presence: true)
  validates(:date, presence: true)
  validates(:location, presence: true)

  scope(:upcoming, ->() {
    today = DateTime.now
    today_zero = DateTime.new(today.year, today.month, today.day, 0, 0, 0)
    where("date >= ?", today_zero)
  })

  scope(:past, ->() {
    today = DateTime.now
    today_zero = DateTime.new(today.year, today.month, today.day, 0, 0, 0)
    where("date < ?", today_zero)
  })
end
