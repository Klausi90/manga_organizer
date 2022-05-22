
module Rbcat
  def self.colorize(string, options = {})
    Colorizer.colorize(string, **options)
  end
end
