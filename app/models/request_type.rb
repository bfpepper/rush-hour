class RequestType < ActiveRecord::Base
  has_many :payloads
  validates :request, presence: true

  def self.most_frequent
    request = Payload.all.group(:request_type_id)
    
    request.group(:request).count.maximum
  end
end
