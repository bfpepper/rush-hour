class Url < ActiveRecord::Base
  has_many :payloads
  has_many :request_types, through: :payloads
  has_many :referrers, through: :payloads
  has_many :agents, through: :payloads

  validates :url, presence: true

  def self.most_to_least_requested
    url_key = Payload.all.group(:url_id).order('count(*) DESC').count.keys
    url_key.map {|key| Url.find(key).url}
  end

  def self.min_response(url)
    Url.find_by(url: url).payloads.minimum("responded_in")
  end

  def self.max_response(url)
    Url.find_by(url: url).payloads.maximum("responded_in")
  end

  def self.ordered_response_times(url)
    Url.find_by(url: url).payloads.order(responded_in: :desc).map {|payload| payload.responded_in}
  end

  def self.average_response_time(url)
    Url.find_by(url: url).payloads.average('responded_in')
  end

  def self.verb_list(url)
    Url.find_by(url: url).request_types.map{|request_type| request_type.request}.uniq
  end

  def self.top_referrers(url)
    Url.find_by(url: url).referrers.group_by {|referrer| referrer.url}.sort_by {|k, v| v.count}.reverse.map {|referrer| referrer.first}[0..2]
  end

  def self.top_agents(url)
    Url.find_by(url: url).agents.group_by {|agent| "#{agent.os} #{agent.browser}" }.sort_by {|k,v| v.count }.reverse.map {|agent| agent.first}[0..2]
  end

end
