class Link < ApplicationRecord
  belongs_to :user
  has_many :access_logs, dependent: :destroy

  validates_presence_of :url, :slug
  validates_uniqueness_of :url, :scope => :user
  validates :name, length: { maximum: 255 }
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https])}

  before_validation :generate_slug

  def shortened_url(request)
    return "#{request.protocol}#{request.host_with_port}/l/#{slug}"
  end

  def allow_access?
    true
  end

  private

  def generate_slug
    candidate_slug = SecureRandom.hex(6)[0..5]
    while Link.exists?(slug: candidate_slug)
      candidate_slug = SecureRandom.hex(6)[0..5]
    end
    self.slug = candidate_slug
  end
end
