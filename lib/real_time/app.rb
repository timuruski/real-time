require 'scorched'

module RealTime
  class App < Scorched::Controller
    get '/' do
      'Hello world'
    end
  end
end
