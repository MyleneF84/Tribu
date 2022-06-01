class Event < ApplicationRecord
  belongs_to :user, optional: true
  has_many :event_categories, dependent: :destroy
  has_many :categories, through: :event_categories
  has_many :bookings

  validates :name, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :phone_number, numericality: { only_integer: true }
  validates :start_at, :end_at, presence: true
  has_one_attached :photo
end
