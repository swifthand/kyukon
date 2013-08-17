module Kyukon
  class Desktop

    def initialize(ignored_workspaces = [])
      @workspaces = determine_workspaces(ignored_workspaces)
      @cursor = 0
    end

    def determine_workspaces(ignored_workspaces)
      (`wmctrl -d`.split(/\n/).map { |line| line.split(/\s/).first }) - ignored_workspaces
    end

    def next
      advance_cursor(1)
      switch_to_cursor
    end

    def prev
      advance_cursor(-1)
      switch_to_cursor
    end

    def advance_cursor(by)
      @cursor = (@cursor + by) % @workspaces.count
    end

    def switch_to_cursor
      `wmctrl -s #{@workspaces[@cursor]}`
    end

  end
end