class AccessLog < ApplicationRecord
  belongs_to :link

  validates :access_date, :ip_address, presence: true
end
