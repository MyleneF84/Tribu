class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event
  STATUS = %w[accepted declined en-attente]
  validates :status, inclusion: { in: STATUS }
  #validates :rating
  #validates :rating, numericality: { only_integer: true }
  #validates :rating, inclusion: { in: (0..5) }
end
