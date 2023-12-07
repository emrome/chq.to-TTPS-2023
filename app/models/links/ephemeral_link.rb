class EphemeralLink < Link
    validates :expiration_date, presence: true
end
