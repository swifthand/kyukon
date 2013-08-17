#!/usr/bin/env ruby

module Kyukon
end

require 'require_all'
# Ruby std libs and other gems
require 'yaml'
require 'singleton'
require 'active_support/all'
# My stuff.
require_all ['boards', 'desktop', 'daemon']


Kyukon::Daemon.new.run
