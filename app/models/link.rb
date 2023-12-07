class Link < ApplicationRecord
  belongs_to :user
  has_many :access_logs, dependent: :destroy

  validates_presence_of :url, :slug
  validates_uniqueness_of :url, :slug
  validates :name, length: { maximum: 255 }
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https])}

  before_validation :generate_slug

  def self.types
    descendants.map(&:name)
  end

  private

  def generate_slug
    self.slug ||= SecureRandom.hex(6)
  end
end
