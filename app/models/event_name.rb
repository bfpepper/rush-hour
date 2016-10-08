class EventName < ActiveRecord::Base
  has_many :payloads
  validates :event, presence: true

end
