module Kyukon
  class PrintNumber < Board

    def resume
      3.times do
        puts number
        sleep 1
      end
    end

    def number
      @number ||= Time.now.sec % rand(17)
    end

  end
end