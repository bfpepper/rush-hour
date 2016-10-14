class Agent < ActiveRecord::Base
  has_many :payloads

  validates :os, presence: true
  validates :browser, presence: true

  def self.browser_breakdown
    browsers = all.group(:agent_id).order('count(*) DESC').count.keys

    browsers.map do |browser_id|
      find(browser_id).browser
    end
  end

  def self.os_breakdown
    os = all.group(:agent_id).order('count(*) DESC').count.keys

    os.map do |os_id|
      find(os_id).os
    end
  end

end
