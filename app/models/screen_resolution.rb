class ScreenResolution < ActiveRecord::Base
  has_many :payloads
  validates :width, presence: true
  validates :height, presence: true

  def self.screen_breakdown
    sr = all.group(:screen_resolution_id).order('count(*) DESC').count.keys

    sr.map do |sr_id|
      height = find(sr_id).height
      width = find(sr_id).width
      "#{width} x #{height}"
    end
  end
end
