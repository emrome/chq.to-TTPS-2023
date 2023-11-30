class Link < ApplicationRecord
  belongs_to :user
  has_many :access_logs

  validates :url, presence: true, uniqueness: true
  validates :name, length: { maximum: 255 }

  before_validation :generate_slug

  private

  def generate_slug
    self.slug ||= SecureRandom.hex(6)
  end
end
