module Kyukon
  class Dashboard

    def initialize(boards)
      @boards = boards
      @workspaces = determine_workspaces(@boards, determine_ignored_boards(@boards))
      @cursor = 0
      @desktop = Desktop.new
      switch_to_cursor
    end


    def determine_ignored_boards(boards)
      boards.map(&:ignore?).
        each.with_object([]).with_index do |(ignore, acc), idx|
          acc << idx.to_s if ignore
        end
    end


    def determine_workspaces(boards, ignored_boards)
      ((all_workspace_ids - ignored_boards).map do |workspace_id|
        Workspace.new(workspace_id.to_i, boards[workspace_id.to_i])
      end).select(&:board)
    end


    def all_workspace_ids
      (`wmctrl -d`.split(/\n/).map { |line| line.split(/\s/).first })
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
      @desktop << @workspaces[@cursor]
    end

  end
end