class EphemeralLink < ApplicationRecord
    validates :expiration_date, presence: true
end
