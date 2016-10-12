class Client < ActiveRecord::Base
  has_many :payloads
  has_many :urls, through: :payloads
  has_many :ips, through: :payloads
  has_many :referrers, through: :payloads
  has_many :request_types, through: :payloads
  has_many :screen_resolutions, through: :payloads
  has_many :agents, through: :payloads
  has_many :events, through: :payloads

  validates :identifier, presence: true
  validates :root_url, presence: true

  def hourly_breakdown(event)
    payloads.where(event: event.id).group("extract(hour from requested_at)").count
  end
end
