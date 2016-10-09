class Agent < ActiveRecord::Base
  has_many :payloads

  validates :os, presence: true
  validates :browser, presence: true

  def self.browser_breakdown
    browsers = Payload.all.group(:agent_id).order('count(*) DESC').count.keys

    browsers.map do |browser_id|
      Agent.find(browser_id).browser
    end
  end

  def self.os_breakdown
    os = Payload.all.group(:agent_id).order('count(*) DESC').count.keys
    os.map do |os_id|
      Agent.find(os_id).os
    end
  end

end
