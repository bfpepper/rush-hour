class Agent < ActiveRecord::Base
  has_many :payloads

  validates :os, presence: true
  validates :browser, presence: true

end
