# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create users
p 'Creating users...'
john_doe = User.create!(first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com', username: 'johndoe', password: 'password123', created_at: DateTime.now - 10.days)

jane_smith = User.create!(first_name: 'Jane', last_name: 'Smith', email: 'jane.smith@example.com', username: 'janesmith', password: 'password456', created_at: DateTime.now - 8.days
)

# Create links
p 'Creating links...'
private_link = PrivateLink.create!(name: 'Imagine', url: 'https://www.youtube.com/watch?v=VOgFZfRVaww', created_at: DateTime.now - 9.days, password: 'Imagine123', user: john_doe)

regular_link = RegularLink.create!(name: 'The Godfather', url: 'https://www.youtube.com/watch?v=sY1S34973zA', created_at: DateTime.now - 7.days, user: john_doe)

EphemeralLink.create!(name: 'Google',url: 'https://www.google.com/',created_at: DateTime.now - 6.days,user: john_doe)

temporary_link = TemporaryLink.create!(url: 'https://doodles.google/search/', created_at: DateTime.now - 4.days, expiration_date: Time.zone.now + 30.minutes, user: john_doe)

temporary_expired_link = TemporaryLink.create!(url: 'https://doodles.google/search/', created_at: DateTime.now - 4.days, expiration_date: Time.zone.now + 1.minutes, user: jane_smith)

EphemeralLink.create!(name: 'Google',url: 'https://www.google.com/',created_at: DateTime.now - 6.days,user: jane_smith).access_logs.create!(ip_address: "154.85.40.1", access_date: Time.zone.now - 2.days)

# Log access
# Method to log accesses for a link
def log_accesses(link, num_ips)
  link.save!
  num_ips.times do
    ip_address = Faker::Internet.ip_v4_address
    num_accesses = rand(10..50)

    num_accesses.times do
      date = Faker::Time.between(from: link.created_at, to: Time.zone.now)
      link.access_logs.create(ip_address: ip_address.to_s, access_date: date)
    end
  end
end


p 'Logging access...'

log_accesses(private_link, rand(1..10))
log_accesses(regular_link, rand(1..10))
log_accesses(temporary_link, rand(1..10))
log_accesses(temporary_expired_link, rand(1..10))


p 'Done!'