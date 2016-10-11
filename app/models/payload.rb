class Payload < ActiveRecord::Base
  belongs_to :ip
  belongs_to :referrer
  belongs_to :request_type
  belongs_to :screen_resolution
  belongs_to :url
  belongs_to :agent
  belongs_to :client
  belongs_to :event

  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :ip_id, presence: true
  validates :url_id, presence: true
  validates :referrer_id, presence: true
  validates :agent_id, presence: true
  validates :screen_resolution_id, presence: true
  validates :request_type_id, presence: true
  validates :event_id, presence: true

  def self.average_response
    average("responded_in")
  end

  def self.max_response
    maximum("responded_in")
  end

  def self.min_response
    minimum("responded_in")
  end

  def self.payload_constructor(params)
    input = JSON.parse(params[:payload])

    Payload.create(
                    requested_at: input["requestedAt"],
                    url: Url.find_or_create_by(url: input["url"]),
                    responded_in: input["respondedIn"],
                    referrer: Referrer.find_or_create_by(url: input["referredBy"]),
                    request_type: RequestType.find_or_create_by(request: input["requestType"]),
                    event_id: Event.find_or_create_by(event: input["eventName"]).id,
                    agent: Agent.find_or_create_by(os: UserAgent.parse(input["userAgent"].gsub('%3B',';')).platform, browser: UserAgent.parse(input["userAgent"]).browser),
                    screen_resolution: ScreenResolution.find_or_create_by(width: input["resolutionWidth"], height: input["resolutionHeight"]),
                    ip: Ip.find_or_create_by(address: input["ip"]),
                    client: Client.find_by(identifier: params["IDENTIFIER"])
    )
  end

  def self.already_exists?(params)
    input = JSON.parse(params[:payload])
    pay = Payload.where(requested_at: input["requestedAt"],
                    url: Url.find_by(url: input["url"]),
                    responded_in: input["respondedIn"],
                    referrer: Referrer.find_by(url: input["referredBy"]),
                    request_type: RequestType.find_by(request: input["requestType"]),
                    event: Event.find_by(event: input["eventName"]),
                    agent: Agent.find_by(os: UserAgent.parse(input["userAgent"].gsub('%3B',';')).platform, browser: UserAgent.parse(input["userAgent"]).browser),
                    screen_resolution: ScreenResolution.find_by(width: input["resolutionWidth"], height: input["resolutionHeight"]),
                    ip: Ip.find_by(address: input["ip"]),
                    client: Client.find_by(identifier: params["IDENTIFIER"])
                    )
    binding.pry
  end
end
