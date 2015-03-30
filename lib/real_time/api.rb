require 'scorched'
require 'json'

require 'real_time/poll_repository'

module RealTime
  class Api < Scorched::Controller
    # Enable JSON content.
    JSON_CONTENT = 'application/json'.freeze
    # before content_type: JSON_CONTENT do
    #   request.POST = JSON.parse request.body
    # end

    after media_type: JSON_CONTENT do
      if response.body
        request['Content-Type'] = JSON_CONTENT
        response.body = JSON.generate response.body
      end
    end

    get '/' do
      polls.all
    end

    post '/' do
      poll_name = request.POST['name']
      polls.create(name: poll_name)

      nil
    end

    get '/:id' do
      poll_id = request.captures[:id]
      poll = polls.find(poll_id)

      poll or halt 404
    end

    delete '/:id' do
      poll_id = request.captures[:id]
      polls.destroy(poll_id)

      nil
    end

    post '/:id/:option' do
      'vote'
    end

    def polls
      @polls = PollRepository.new
    end
  end
end
