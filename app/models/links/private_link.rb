require 'bcrypt'
class PrivateLink < Link
    include BCrypt

    validates :password, presence: true, length: { minimum: 8 }
    def password=(new_password)
        @password = Password.create(new_password)
    end

    def check_password(password)
        @password.is_password?(password)
    end
end
