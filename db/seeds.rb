

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

puts 'Creating Events...'

event1 = Event.create!(
  name: "Foire au Dindon",
  description: "Venez découvrir nos beaux Dindons de la région. Bien nourris, bien dodus, ils gloussent du matin au soir. Mais ne vous méprenez pas, leur timbre est doux et délicat! Ils régaleront aussi bien vos yeux que vos papilles !",
  address: "36 route du Luberon, 91320 WISSOUS",
  price: "10",
  start_at: Date.today,
  end_at: Date.tomorrow,
  user: user1
)

event2 = Event.create!(
  name: "Marché aux fleurs",
  description: "Le lieu aux milles odeurs et couleurs. L'endroit idéal pour flâner seul ou à deux, pour offrir ou se faire plaisir !",
  address: "4 rue Jean-Jaurès, 94240 l'Haÿ-les-Roses",
  price: "5",
  start_at: Date.yesterday,
  end_at: Date.today,
  user: user2
)

event3 = Event.create!(
  name: "Balade à Vélo",
  description: "Laissez vous guider par notre Cécé nationale à travers la ville. Aucun recoin n'a de secret pour elle. Elle vous fera découvrir des petits recoins au charme fou. Elle s'adapte à votre rythme, pour une balade tranquille ou plus sportive.",
  address: "4 allée mansart, 94260 FRESNES",
  price: "20",
  start_at: Date.today,
  end_at: Date.tomorrow,
  user: user3
)

puts 'Finished!'
