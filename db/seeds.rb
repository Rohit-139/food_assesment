
puts "Deleting old data..."

Dish.destroy_all
Restaurant.destroy_all
User.destroy_all

puts "Creating Owners..."

owner1 = Owner.create!(
  name: "Rohit Owner",
  email: "rohit.owner@gmail.com",
  password: "password123",
  password_confirmation: "password123",
  type: "Owner"
)

owner2 = Owner.create!(
  name: "Amit Owner",
  email: "amit.owner@gmail.com",
  password: "password123",
  password_confirmation: "password123",
  type: "Owner"
)

owner3 = Owner.create!(
  name: "Neha Owner",
  email: "neha.owner@gmail.com",
  password: "password123",
  password_confirmation: "password123",
  type: "Owner"
)

puts "Owners created: #{Owner.count}"

puts "Creating Restaurants..."

restaurant1 = owner1.restaurants.create!(
  name: "Spicy Hub",
  description: "Best spicy food in town",
  rating: 4.5,
  street: "Gita bhawan",
  city: "Indore",
  state: "Madhya Pradesh"
)

restaurant2 = owner1.restaurants.create!(
  name: "Pizza Point",
  description: "Delicious pizzas and sides",
  rating: 4.2,
  street: "Vijay Nagar",
  city: "Indore",
  state: "Madhya Pradesh"
)

restaurant3 = owner2.restaurants.create!(
  name: "Burger House",
  description: "Juicy burgers available",
  rating: 4.0,
  street: "shivaji vatika",
  city: "indore",
  state: "Madhya pradesh"
)

restaurant4 = owner2.restaurants.create!(
  name: "South Express",
  description: "Authentic south indian food",
  rating: 4.6,
  street: "bada ganpati",
  city: "indore",
  state: "Madhya pradesh"
)

restaurant5 = owner3.restaurants.create!(
  name: "Chinese Corner",
  description: "Chinese and fast food",
  rating: 4.3,
  street: "Khajrana",
  city: "Indore",
  state: "Madhya pradesh"
)

restaurant6 = owner3.restaurants.create!(
  name: "Food Paradise",
  description: "Multi cuisine restaurant",
  rating: 4.7,
  street: "robot square",
  city: "Indore",
  state: "Madhya pradesh"
)

puts "Restaurants created: #{Restaurant.count}"

puts "Creating Dishes..."

restaurants = Restaurant.all

restaurants.each do |restaurant|
  restaurant.dishes.create!(
    name: "Paneer Butter Masala",
    description: "Creamy paneer curry",
    price: 250,
    stock: 20
  )

  restaurant.dishes.create!(
    name: "Veg Biryani",
    description: "Delicious veg biryani",
    price: 180,
    stock: 15
  )

  restaurant.dishes.create!(
    name: "Masala Dosa",
    description: "Crispy dosa with potato filling",
    price: 120,
    stock: 25
  )

  restaurant.dishes.create!(
    name: "Veg Noodles",
    description: "Chinese style noodles",
    price: 150,
    stock: 18
  )
end

puts "Dishes created: #{Dish.count}"

puts "Seeding completed successfully!"

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
