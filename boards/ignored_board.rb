module Kyukon
  class IgnoredBoard < Board

    def ignore?
      true
    end

    def run
      puts "Ignored board is somehow running. What the hell?"
    end

  end
end