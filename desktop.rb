module Kyukon
  class Desktop

    def initialize
      @workspaces = Queue.new
      start
    end

    def start
      Thread.new do
        loop do
          workspace = @workspaces.pop
          workspace.focus
          workspace.resume
        end
      end
    end

    def <<(workspace)
      @workspaces << workspace
    end

  end


  class Workspace < ImmutableStruct.new(:id, :board)

    def focus
      `wmctrl -s #{id}`
    end

    def resume
      board.resume
    end

  end

end