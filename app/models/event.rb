class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :name, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :phone_number, numericality: { only_integer: true }
  validates :start_at, :end_at, presence: true
end
