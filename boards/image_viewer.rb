module Kyukon
  class ImageViewer < Board

    attr_reader :xdo, :image_path

    def initialize(image_path)
      @image_path = image_path
      @xdo = XDo.new
    end


    def initialized?
      @initialized ||= false
    end


    def setup
      return false if initialized?
      Process.spawn("#{viewer_command} #{options} #{image_path}")
      sleep boot_delay
      full_screen
      @initialized = true
    end

    def options
      ""
    end


    def viewer_command
      "viewnior"
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