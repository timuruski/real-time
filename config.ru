require_relative 'env'
require 'rack/parser'
require 'real_time/api'

DECODE_JSON = ->(body) { JSON.parse(body) }
RACK_PARSER_CONFIG = { 'application/json' => DECODE_JSON }

app = Rack::Builder.new do
  map '/polls' do
    use Rack::Parser, RACK_PARSER_CONFIG
    run RealTime::Api
  end
end

run app
