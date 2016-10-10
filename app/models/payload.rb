class Payload < ActiveRecord::Base
  belongs_to :ip
  belongs_to :referrer
  belongs_to :request_type
  belongs_to :screen_resolution
  belongs_to :url
  belongs_to :agent
  belongs_to :client

  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :ip_id, presence: true
  validates :url_id, presence: true
  validates :referrer_id, presence: true
  validates :agent_id, presence: true
  validates :screen_resolution_id, presence: true
  validates :request_type_id, presence: true
  validates :event_name_id, presence: true

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
                    url_id: Url.find_or_create_by(url: input["url"]).id,
                    responded_in: input["respondedIn"],
                    referrer_id: Referrer.find_or_create_by(url: input["referredBy"]).id,
                    request_type_id: RequestType.find_or_create_by(request: input["requestType"]).id,
                    event_name_id: EventName.find_or_create_by(event: input["eventName"]).id,
                    agent_id: Agent.find_or_create_by(os: UserAgent.parse(input["userAgent"].gsub('%3B',';')).platform, browser: UserAgent.parse(input["userAgent"]).browser).id,
                    screen_resolution_id: ScreenResolution.find_or_create_by(width: input["resolutionWidth"], height: input["resolutionHeight"]).id,
                    ip_id: Ip.find_or_create_by(address: input["ip"]).id,
                    client_id: Client.find_by(identifier: params["IDENTIFIER"]).id
    )
  end
end
