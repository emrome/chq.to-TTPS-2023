class TemporaryLink < Link
    validate :expiration_date_validity

    def expired?
        self.expiration_date < Time.zone.now
    end

    private
    def expiration_date_validity
        if expiration_date.present? && expiration_date <= Time.zone.now
            errors.add(:expiration_date, "must be greater than or equal to the current time")
        end
    end
end
