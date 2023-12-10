class TemporaryLink < Link
    validates :expiration_date, presence: true
    validate :expiration_date_validity, on: :create

    def allow_access?
        self.expiration_date > Time.zone.now
    end

    private
    def expiration_date_validity
        if expiration_date.present? && expiration_date <= Time.zone.now
            errors.add(:expiration_date, "must be greater than the current time")
        end
    end
end
