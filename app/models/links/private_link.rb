require 'bcrypt'

class PrivateLink < Link
    before_save :encrypt_password, if: :password_changed?
  
    validates :password, presence: true, length: { minimum: 8 }

    private
    def encrypt_password
        self.password = BCrypt::Password.create(password)
    end

end
