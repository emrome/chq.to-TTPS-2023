class EphemeralLink < Link
    def allow_access?
        self.access_logs.count < 1
    end
end
