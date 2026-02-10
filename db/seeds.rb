# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
# puts "🌱 Seeding data..."

# =========================
# # OWNER USER
# # =========================
# owner = User.create!(
#   name: "Rahul Sharma",
#   email: "owner@gmail.com",
#   password: "password",
#   role: "owner"
# )

# puts "✅ Owner created"

# # =========================
# # RESTAURANT
# # =========================
# restaurant = Restaurant.create!(
#   name: "Spicy Treat",
#   description: "Best Indian & Chinese food in town",
#   rating: 4.5,
#   user: owner
# )

# puts "✅ Restaurant created"

# # =========================
# # DISHES
# # =========================
# dishes = [
#   {
#     name: "Paneer Butter Masala",
#     description: "Creamy paneer curry with butter & spices",
#     price: 250
#   },
#   {
#     name: "Chicken Biryani",
#     description: "Hyderabadi style dum biryani",
#     price: 320
#   },
#   {
#     name: "Veg Hakka Noodles",
#     description: "Chinese style noodles with veggies",
#     price: 180
#   },
#   {
#     name: "Butter Naan",
#     description: "Soft naan topped with butter",
#     price: 40
#   },
#   {
#     name: "Masala Dosa",
#     description: "Crispy dosa with potato filling",
#     price: 120
#   }
# ]

# dishes.each do |dish|
#   restaurant.dishes.create!(dish)
# end

# puts "✅ Dishes created"

# puts "🎉 Seeding completed successfully!"
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?