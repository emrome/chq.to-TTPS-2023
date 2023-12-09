class TemporaryLink < Link
    validates :expiration_date, presence: true, comparison: { greater_than_or_equal_to: Date.today }

    def expired?
        self.expiration_date < Date.today
    end

end
