#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require_relative './../lib/runner'

# Loading dependent gems
require 'colorize'

runner = CourierFacility::Runner.new(ARGV)

runner.run