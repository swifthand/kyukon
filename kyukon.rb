#!/usr/bin/env ruby

module Kyukon
  DEBUG = false
end

require 'rubygems'
require 'bundler/setup'
require 'require_all'
# Ruby std libs and other gems
require 'yaml'
require 'immutable_struct'
require 'singleton'
require 'active_support/all'
require 'x_do'
# My stuff.
require_all ['board', 'boards', 'dashboard', 'desktop', 'daemon']


Thread.abort_on_exception = true
Kyukon::Daemon.new.run
