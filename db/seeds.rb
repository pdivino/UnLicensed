# Seed file: fills the database with starter data.
# Run with: rails db:seed
# find_or_create_by! = only creates a record if it doesn't already exist,
# so running this twice won't make duplicates.

# Starter admin account (created by ActiveAdmin's installer).
if Rails.env.development?
  AdminUser.find_or_create_by!(email: "admin@example.com") do |admin|
    admin.password = "password"
    admin.password_confirmation = "password"
  end
end

# The five UnLicensed clothing categories.
categories = {}
[ "Shirts", "Shorts", "Hoodies", "Pants", "Socks" ].each do |name|
  categories[name] = Category.find_or_create_by!(name: name)
end

# Products with real names and descriptions (rubric 1.2 needs at least 10).
products = [
  { name: "Heavyweight Work Tee", category: "Shirts", price: 39.99, stock: 25,
    description: "Thick 100% cotton tee built for long shifts and weekends." },
  { name: "Prairie Pocket Tee", category: "Shirts", price: 34.99, stock: 30,
    description: "Relaxed-fit cotton tee with a chest pocket and a small prairie skyline print." },
  { name: "Canvas Work Shirt", category: "Shirts", price: 74.99, stock: 12,
    description: "Button-up shirt in washed cotton canvas with two flap pockets." },
  { name: "Canvas Work Shorts", category: "Shorts", price: 59.99, stock: 18,
    description: "Durable canvas shorts with a hammer loop and reinforced back pockets." },
  { name: "Ripstop Utility Shorts", category: "Shorts", price: 54.99, stock: 20,
    description: "Lightweight ripstop shorts with cargo pockets for summer markets and job sites." },
  { name: "Prairie Work Hoodie", category: "Hoodies", price: 64.99, stock: 15,
    description: "Heavyweight cotton hoodie with a kangaroo pocket." },
  { name: "Thermal-Lined Zip Hoodie", category: "Hoodies", price: 84.99, stock: 10,
    description: "Full-zip hoodie with a waffle-knit thermal lining for Winnipeg winters." },
  { name: "Double-Knee Carpenter Pants", category: "Pants", price: 89.99, stock: 14,
    description: "Classic carpenter pants with reinforced double knees and a tool pocket." },
  { name: "Trail Hiking Pants", category: "Pants", price: 79.99, stock: 16,
    description: "Stretch hiking pants with a water-resistant finish and zip pockets." },
  { name: "Heavy Wool Work Socks", category: "Socks", price: 19.99, stock: 40,
    description: "Thick wool-blend socks with a cushioned sole for steel-toe boots." },
  { name: "Everyday Crew Socks 3-Pack", category: "Socks", price: 24.99, stock: 35,
    description: "Three pairs of soft cotton crew socks with the UnLicensed logo at the ankle." },
  { name: "Long Sleeve Logo Tee", category: "Shirts", price: 44.99, stock: 22,
    description: "Heavyweight long sleeve tee with a bold UnLicensed logo on the back." }
]

products.each do |p|
  Product.find_or_create_by!(name: p[:name]) do |product|
    product.category = categories[p[:category]]
    product.description = p[:description]
    product.price = p[:price]
    product.stock_quantity = p[:stock]
  end
end

puts "Seeded #{Category.count} categories and #{Product.count} products."