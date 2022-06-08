class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event
  STATUS = %w[accepted declined en-attente]
  validates :status, inclusion: { in: STATUS }
  validates :rating, numericality: { only_integer: true }, inclusion: { in: (1..5) }, allow_nil: true
end
