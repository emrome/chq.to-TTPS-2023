require 'bcrypt'
class PrivateLink < Link
    include BCrypt
    has_secure_password

    validates :password, presence: true, length: { minimum: 8 }
end
