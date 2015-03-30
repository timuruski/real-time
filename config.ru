require_relative 'env'
require 'rack/contrib'
require 'real_time/api'

app = Rack::Builder.new do
  map '/polls' do
    use Rack::PostBodyContentTypeParser
    run RealTime::Api
  end
end

run app
