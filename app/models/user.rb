class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many(:events, foreign_key: "creator_id")

  validates(:username, presence: true)
  validates(:email, presence: true)
  validates(:password, presence: true, length: { minimum: 6 })
end
