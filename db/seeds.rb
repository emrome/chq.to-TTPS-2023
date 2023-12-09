# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Method to log access for a link
def log_accesses(link, ip_addresses, access_date = nil)
    link.save!
    ip_addresses.each do |ip_address|
        date = access_date || Time.zone.now
        link.access_logs.create(ip_address: ip_address, access_date: date)
    end
end

# Create users
User.destroy_all
john_doe = User.create!(
  first_name: 'John',
  last_name: 'Doe',
  email: 'john.doe@example.com',
  username: 'johndoe',
  password: 'password123',
  password_confirmation: 'password123',
  created_at: DateTime.now - 10.days
)

jane_smith = User.create!(
  first_name: 'Jane',
  last_name: 'Smith',
  email: 'jane.smith@example.com',
  username: 'janesmith',
  password: 'password456',
  password_confirmation: 'password456'
)

# Create links
Link.destroy_all

private_link = PrivateLink.create!(
  name: 'Imagine',
  url: 'https://www.youtube.com/watch?v=VOgFZfRVaww',
  created_at: DateTime.now - 9.days,
  password: 'Imagine123',
  user: john_doe
)

regular_link = RegularLink.create!(
  name: 'The Godfather',
  url: 'https://www.youtube.com/watch?v=sY1S34973zA',
  created_at: DateTime.now - 7.days,
  user: john_doe
)

EphemeralLink.create!(
  name: 'Google',
  url: 'https://www.google.com/',
  user: john_doe
)

TemporaryLink.create!(
  url: 'https://doodles.google/search/',
  expiration_date: Time.zone.now + 30.minutes,
  user: john_doe
)

log_accesses(private_link, ["127.0.0.1", "192.168.142.86"])
log_accesses(regular_link, ["127.0.0.1", "172.30.0.1"])