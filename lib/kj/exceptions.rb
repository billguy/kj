module Kj
  class Iniquity < StandardError
    def initialize(msg = "Not found")
      super(msg)
    end
  end
end