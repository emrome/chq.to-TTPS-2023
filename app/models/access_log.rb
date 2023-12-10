class AccessLog < ApplicationRecord
  belongs_to :link

  validates :access_date, :ip_address, presence: true

  scope :filter_by_ip_address, -> (ip_address) { where("ip_address LIKE ?", "#{ip_address}%") }
  scope :filter_by_start_date, ->(start_date) { where('access_date >= ?', start_date) }
  scope :filter_by_end_date, ->(end_date) { where('access_date <= ?', end_date) }

end