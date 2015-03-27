require 'bundler/setup'

require 'dotenv'
Dotenv.load

$:.unshift File.expand_path './lib', __dir__

require 'real_time'
