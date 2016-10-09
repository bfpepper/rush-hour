class Url < ActiveRecord::Base
  has_many :payloads
  validates :url, presence: true

  def self.most_to_least_requested
    url_key = Payload.all.group(:url_id).order('count(*) DESC').count.keys
    url_key.map {|key| Url.find(key).url}
  end


end
