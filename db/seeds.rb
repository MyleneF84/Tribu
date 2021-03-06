require "open-uri"
require "nokogiri"

Booking.destroy_all
Event.destroy_all
User.destroy_all

puts 'Creating Users...'
user1 = User.create!(
  email: "Alexis@testmail.com",
  first_name: "Alexis",
  last_name: "Denorme",
  password: "azerty"
)

user2 = User.create!(
  email: "Pauline@gmail.com",
  first_name: "Pauline",
  last_name: "Bertrand",
  password: "azerty"
)

user3 = User.create!(
  email: "Claire@testmail.com",
  first_name: "Claire",
  last_name: "Kadjar",
  password: "azerty"
)
puts 'Finished!'



puts 'Creating categories'
# parametres de scrapping
distance = 40 # kilometres
location = "france,provence-alpes-cote-d-azur,vaucluse,oppede"
date = Date.today.strftime("%Y_%m_%d") # aka a partir d'aujourd'hui
categories = ["brocante-vide-grenier", "fete", "marche", "repas-degustation", "musique", "exposition" ]
categories_private = ["balades-visites", "nature-environnement", "sport", "entraide", "arts", "plantes-potager"]
# categories_public = ["brocante-vide-grenier", "fete", "marche", "repas-degustation", "musique", "exposition" ]
# categories_private = ["sport", "etc." ]

# SCRAPPING
categories.each do |category|
  url = "https://www.eterritoire.fr/evenements/#{location}/_datedebut-#{date},#{category},xrac-#{distance}"
  p url
  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML(html_file)
  html_doc.search('[itemtype="https://schema.org/Event"]').each do |element|
    event_name = element.search('[itemprop="name"]').first.inner_html
    description = element.search(".dsc p").first.inner_html
    address = element.search('[itemprop="address"]').inner_text
    start_time = element.search('[itemprop="startDate"]').first.attributes["content"].value
    end_time = element.search('[itemprop="endDate"]').first.attributes["content"].value
    img = "https://www.eterritoire.fr/#{element.search('img.i.e').first.attributes["src"].value}"
    event1 = Event.create!(
      name: event_name,
      description: description,
      address: address,
      price: "0",
      start_time: Date.parse(start_time),
      end_time: Date.parse(end_time),
      phone_number: "0148658596",
      category: [category]
    )
    event1.photo.attach(io: URI.open(img), filename: "image")
    event1.save
    puts "#{address} ????"
  end
end

puts 'Creating Events...'
event1 = Event.create!(
  name: "Moment ?? la ferme",
  description: "Partagez un moment du quotidien dans ma ferme ! Au programme : nourrir les animaux de la basse-cour, remplir les abreuvoirs, et passez un joli moment avec les agneaux qui viennent de naitre. Les enfants sont ??videmment les bienvenus",
  address: "8 Rue du Couvent, 13430 Eygui??res",
  price: "15",
  category: [categories_private[1], categories_private[3]],
  start_time: Date.today,
  end_time: Date.tomorrow,
  phone_number: "0148658596",
  user: user1
)
event1.photo.attach(io: URI.open("https://res.cloudinary.com/dvtuelr2w/image/upload/v1654003346/maxresdefault_kjiom9.jpg"), filename: "image")
event1.save

event2 = Event.create!(
  name: "Tailler le jardin",
  description: "Mon jardin est immense et poss??de plein de plantes ! Pendant cette journ??e, vous pourrez m'aider ?? m'occuper des fleurs, mais aussi du potager, et vous servir en bouture !",
  address: "Place Victor Hugo, 13560 S??nas",
  price: "10",
  category: [categories_private[5]],
  start_time: Date.yesterday,
  end_time: Date.today,
  phone_number: "0175496352",
  user: user2
)
event2.photo.attach(io: URI.open("https://res.cloudinary.com/dvtuelr2w/image/upload/v1654003265/marche-aux-fleurs-elisabeth-ii-ile-de-la-cite-paris-4-0_w0abqn.jpg"), filename: "image")
event2.save

event3 = Event.create!(
  name: "Balade ?? V??lo",
  description: "Je vous propose une balade ?? velo afin de vous faire d??couvrir diff??rents endroit de la r??gion ! Moment convivial garanti :)",
  address: "Avenue Louis Sammut, 13500 Martigues",
  price: "5",
  category: [categories_private[0], categories_private[2]],
  start_time: Date.today,
  end_time: Date.tomorrow,
  phone_number: "0699584256",
  user: user3
)
event3.photo.attach(io: URI.open("https://res.cloudinary.com/dvtuelr2w/image/upload/v1654003119/image_yoymeb.jpg"), filename: "image")
event3.save
puts 'Finished!'

puts 'Creating Bookings'
Booking.create!(
  user_id: user1.id,
  event_id: event2.id,
  rating: "4",
  status: "accepted",
  reviews: "C'est g??nial !"
)

Booking.create!(
  user_id: user2.id,
  event_id: event3.id,
  rating: "5",
  status: "accepted",
  reviews: "Quel beau moment !"
)

Booking.create!(
  user_id: user3.id,
  event_id: event1.id,
  rating: "3",
  status: "en-attente",
  reviews: "Nous reviendrons, c'est certain :)"
)
puts 'Finished!'
