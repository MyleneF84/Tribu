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
location = "france,ile-de-france,seine-et-marne,moret-loing-et-orvanne"
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
    start_at = element.search('[itemprop="startDate"]').first.attributes["content"].value
    end_at = element.search('[itemprop="endDate"]').first.attributes["content"].value
    img = "https://www.eterritoire.fr/#{element.search('img.i.e').first.attributes["src"].value}"
    event1 = Event.create!(
      name: event_name,
      description: description,
      address: address,
      price: "0",
      start_at: Date.parse(start_at),
      end_at: Date.parse(end_at),
      phone_number: "0148658596",
      category: [category]
    )
    event1.photo.attach(io: URI.open(img), filename: "image")
    event1.save
    puts "Event created 🥳"
  end
end

puts 'Creating Events...'
event1 = Event.create!(
  name: "Moment à la ferme",
  description: "Partagez un moment du quotidien dans ma ferme ! Au programme : nourrir les animaux de la basse-cour, remplir les abreuvoirs, et passez un joli moment avec les agneaux qui viennent de naitre. Les enfants sont évidemment les bienvenus",
  address: "36 route du Luberon, 91320 WISSOUS",
  price: "15",
  category: [categories_private[1], categories_private[3]],
  start_at: Date.today,
  end_at: Date.tomorrow,
  phone_number: "0148658596",
  user: user1
)
event1.photo.attach(io: URI.open("https://res.cloudinary.com/dvtuelr2w/image/upload/v1654003346/maxresdefault_kjiom9.jpg"), filename: "image")
event1.save

event2 = Event.create!(
  name: "Tailler le jardin",
  description: "Mon jardin est immense et possède plein de plantes ! Pendant cette journée, vous pourrez m'aider à m'occuper des fleurs, mais aussi du potager, et vous servir en bouture !",
  address: "4 rue Jean-Jaurès, 94240 l'Haÿ-les-Roses",
  price: "10",
  category: [categories_private[5]],
  start_at: Date.yesterday,
  end_at: Date.today,
  phone_number: "0175496352",
  user: user2
)
event2.photo.attach(io: URI.open("https://res.cloudinary.com/dvtuelr2w/image/upload/v1654003265/marche-aux-fleurs-elisabeth-ii-ile-de-la-cite-paris-4-0_w0abqn.jpg"), filename: "image")
event2.save

event3 = Event.create!(
  name: "Balade à Vélo",
  description: "Je vous propose une balade à velo afin de vous faire découvrir différents endroit de la région ! Moment convivial garanti :)",
  address: "4 allée mansart, 94260 FRESNES",
  price: "5",
  category: [categories_private[0], categories_private[2]],
  start_at: Date.today,
  end_at: Date.tomorrow,
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
  reviews: "C'est génial !"
)

Booking.create!(
  user_id: user2.id,
  event_id: event3.id,
  rating: "5",
  status: "pending",
  reviews: "Quel beau moment !"
)

Booking.create!(
  user_id: user3.id,
  event_id: event1.id,
  rating: "3",
  status: "denied",
  reviews: "Nous reviendrons, c'est certain :)"
)
puts 'Finished!'
