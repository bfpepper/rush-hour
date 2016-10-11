class RequestType < ActiveRecord::Base
  has_many :payloads
  validates :request, presence: true
  def self.most_frequent
    key = Payload.all.group(:request_type_id).order('count(*) DESC').count.first.first
    RequestType.find(key).request
  end

  def self.all_verbs
    RequestType.all.map {|type| type.request}.uniq
  end
end
