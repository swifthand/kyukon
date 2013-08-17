module Kyukon
  class Daemon

    def initialize
      configure
    end


    def configure
      @config = YAML.load_file('config.yml')
      @boards = initialize_boards(@config)
      @dashboard = Dashboard.new(@boards)
    end


    def initialize_boards(config)
      config['boards'].map do |board_name|
        begin
          Kyukon.const_get(board_name).new
        rescue Exception => exc
          IgnoredBoard.new
        end
      end
    end


    def run
      # First argument, 'nochdir', keeps us in the current working directory.
      # Process.daemon(true)
      loop do
        self.wait
        @dashboard.next
      end
    end


    def wait
      sleep @config['delay']
    end

  end
end