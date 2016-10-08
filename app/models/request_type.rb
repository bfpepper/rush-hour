class RequestType < ActiveRecord::Base
  has_many :payloads
  validates :request, presence: true
end
