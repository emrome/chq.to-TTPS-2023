class PrivateLink < Link
    has_secure_password

    validates :password, presence: true, length: { minimum: 8 }, on: :create
end
