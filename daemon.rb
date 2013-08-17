module Kyukon
  class Daemon

    delegate  :next, :prev,
              :to => :@desktop


    def initialize
      configure
    end


    def configure
      @config = YAML.load_file('config.yml')
      @desktop = Desktop.new([*@config['ignore_workspaces']].map(&:to_s))
    end


    def run
      # First argument, 'nochdir', keeps us in the current working directory.
      Process.daemon(true)
      loop do
        self.wait
        self.next
      end
    end


    def wait
      sleep @config['delay']
    end


private #####################################################################


  end
end