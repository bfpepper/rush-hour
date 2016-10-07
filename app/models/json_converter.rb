require 'json'

module JsonConverter

  def self.convert(payload)
    JSON.parse(payload)
  end

end
