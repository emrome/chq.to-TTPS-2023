require 'bcrypt'

class PrivateLink < Link
    before_save :encrypt_password, if: :password_changed?
  
    validates :password, presence: true, length: { minimum: 8 }

    def allow_access?(entered_password)
        BCrypt::Password.new(self.password).is_password?(entered_password)
    end

    private
    def encrypt_password
        self.password = BCrypt::Password.create(password)
    end

end
