class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many(:events, foreign_key: "creator_id")
  has_and_belongs_to_many(:attended_events,
                          join_table: "attended_events",
                          foreign_key: "attendee_id",
                          association_foreign_key: "attended_event_id",
                          class_name: "Event")

  validates(:username, presence: true)
  validates(:email, presence: true)
  validates(:password, presence: true, length: { minimum: 6 })

  def enrolled_to?(event)
    event.attendees.where(id: self).exists?
  end
end
