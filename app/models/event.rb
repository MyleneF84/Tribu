class Event < ApplicationRecord
  CATEGORY = [
    ['brocante-vide-grenier', 'brocante-vide-grenier'],
    ['fête', 'fete'],
    ['marché', 'marche'],
    ['repas-dégustation', 'repas-degustation'],
    ['musique', 'musique'],
    ['exposition', 'exposition'],
    ['balades-visites', 'balades-visites'],
    ['nature-environnement', 'nature-environnement'],
    ['sport', 'sport'],
    ['entraide', 'entraide'],
    ['arts', 'arts'],
    ['plantes-potager', 'plantes-potager']
  ]
  belongs_to :user, optional: true
  #has_many :event_categories, dependent: :destroy
  #has_many :categories, through: :event_categories
  has_many :bookings
  validates :name, presence: true
  validates :description, presence: true
  validates :address, presence: true
  LIST = %w[brocante-vide-grenier fete marche repas-degustation musique exposition balades-visites nature-environnement
    sport entraide arts plantes-potager]
  validates :category, inclusion: { in: LIST }
  validates :phone_number, numericality: { only_integer: true }
  validates :start_time, :end_time, presence: true
  has_one_attached :photo
  validates :price, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
