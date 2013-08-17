module Kyukon
  class GoogleCalendar < ChromiumBrowser

    CALENDAR_URL = "https://www.google.com/calendar"
    MOUSEWHEEL_DOWN = 5
    NUM_SCROLLS = 7

    attr_accessor :last_adjust_time

    def initialize
      @last_adjust_time = 1.year.ago
      super(CALENDAR_URL)
    end


    def resume
      setup
      adjust_ui if should_adjust_ui?
    end


    def adjust_ui
      reset_view
      scroll_view
      record_adjust_time
    end


    def should_adjust_ui?
      last_adjust_time < 12.hours.ago
    end


    def record_adjust_time
      last_adjust_time = Time.now
    end


    def reset_view
      # Reload calendar data
      xdo.keyboard.type_keysequence "r"
      sleep 0.5
      # Change to 'custom view', likely 4 days
      xdo.keyboard.type_keysequence "4"
      # Focus on today
      xdo.keyboard.type_keysequence "t"
    end


    def scroll_view
      width, height = xdo.active_window.size
      xdo.active_window.move_mouse_async(width / 2, height / 2)
      NUM_SCROLLS.times { xdo.mouse.click MOUSEWHEEL_DOWN }
      xdo.mouse.move_async width, height, xdo.mouse.location[2]
    end

  end
end