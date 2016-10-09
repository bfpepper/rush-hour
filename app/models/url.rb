class Url < ActiveRecord::Base
  has_many :payloads
  has_many :request_types, through: :payloads
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

end
