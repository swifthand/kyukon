module Kyukon
  class ChromiumBrowser < Board

    attr_reader :xdo, :url

    def initialize(url)
      @url = url
      @xdo = XDo.new
    end


    def initialized?
      @initialized ||= false
    end


    def setup
      return false if initialized?
      `#{chromium_command} --new-window #{url}`
      sleep boot_delay
      full_screen
      @initialized = true
    end


    def chromium_command
      "chromium-browser"
    end


    def boot_delay
      3.seconds
    end


    def full_screen
      xdo.keyboard.type_keysequence "F11"
    end


    def resume
      setup
    end

  end
end