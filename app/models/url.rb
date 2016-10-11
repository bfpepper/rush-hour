class Url < ActiveRecord::Base
  has_many :payloads
  has_many :request_types, through: :payloads
  has_many :referrers, through: :payloads
  has_many :agents, through: :payloads

  validates :url, presence: true

  def self.most_to_least_requested
    url_key = Payload.all.group(:url_id).order('count(*) DESC').count.keys
    url_key.map {|key| find(key).url}
  end

  def min_response
    payloads.minimum("responded_in")
  end

  def max_response
    payloads.maximum("responded_in")
  end

  def ordered_response_times
    payloads.order(responded_in: :desc).map {|payload| payload.responded_in}
  end

  def average_response_time
    payloads.average('responded_in')
  end

  def verb_list
    request_types.map{|request_type| request_type.request}.uniq
  end

  def top_referrers
    referrers.group_by {|referrer| referrer.url}.sort_by {|k, v| v.count}.reverse.map {|referrer| referrer.first}[0..2]
  end

  def top_agents
    agents.group_by {|agent| "#{agent.os} #{agent.browser}" }.sort_by {|k,v| v.count }.reverse.map {|agent| agent.first}[0..2]
  end

end
