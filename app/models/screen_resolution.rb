class ScreenResolution < ActiveRecord::Base
  has_many :payloads
  validates :width, presence: true
  validates :height, presence: true

  def self.screen_breakdown
    sr = Payload.all.group(:screen_resolution_id).order('count(*) DESC').count.keys

    sr.map do |sr_id|
      height = ScreenResolution.find(sr_id).height
      width = ScreenResolution.find(sr_id).width
      "#{width} x #{height}"
    end
  end
end
