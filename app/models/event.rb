class Event < ApplicationRecord
  belongs_to :user, optional: true
  #has_many :event_categories, dependent: :destroy
  #has_many :categories, through: :event_categories
  has_many :bookings
  serialize :category, Array
  validates :name, presence: true
  validates :description, presence: true
  validates :address, presence: true
  LIST = %w[brocante-vide-grenier fete marche repas-degustation musique exposition balades-visites nature-environnement
    sport entraide arts plantes-potager]
  validates :category, inclusion: { in: LIST }
  validates :phone_number, numericality: { only_integer: true }
  validates :start_at, :end_at, presence: true
  has_one_attached :photo
  validates :price, presence: true
end
