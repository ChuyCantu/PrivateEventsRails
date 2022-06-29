class CreateAttendedEventsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :attended_events, id: false do |t|
      t.bigint :attended_event_id
      t.bigint :attendee_id
    end

    add_index :attended_events, :attended_event_id
    add_index :attended_events, :attendee_id
  end
end
