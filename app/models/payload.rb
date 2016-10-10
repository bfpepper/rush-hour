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


end
