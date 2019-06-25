# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by(name: "edgar")
User.find_or_create_by(name: "viv")
User.find_or_create_by(name: "diana")
User.find_or_create_by(name: "mateo")

Restaurant.find_or_create_by(name: "Sophie's")
Restaurant.find_or_create_by(name: "Thunder Bun")

Message.create(user: User.find_by(name: "edgar"), restaurant: Restaurant.find_by(name: "Sophie's"), content: "This is Edgar at Sophie's!")
Message.create(user: User.find_by(name: "viv"), restaurant: Restaurant.find_by(name: "Sophie's"), content: "Hey Edgar, this is Viv!")
