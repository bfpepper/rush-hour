class Url < ActiveRecord::Base
  has_many :payloads
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

end
