require 'json'
require 'scorched'

require 'real_time/poll_repository'

module RealTime
  class Api < Scorched::Controller
    JSON_CONTENT = 'application/json'.freeze

    after media_type: JSON_CONTENT do
      if response.body
        request['Content-Type'] = JSON_CONTENT
        response.body = JSON.generate response.body
      end
    end

    get '/' do
      {
        polls: repo.all_polls.map { |poll|
          {
            name: poll[:name],
             href: poll_path(poll[:id])
          }
        }
      }
    end

    post '/' do
      poll_name = request.POST.fetch('name')
      option_names = request.POST.fetch('options')
      poll_id = repo.create_poll(poll_name, option_names)

      poll_path(poll_id)
    end

    get '/:id' do
      poll_id = request.captures[:id]
      poll = repo.find_poll(poll_id)
      options = repo.find_poll_options(poll_id)

      halt 404 if poll.nil?

      {
        name: poll[:name],
        href: poll_path(poll[:id]),
        options: options.map { |option|
          {
            name: option[:name],
            votes: option[:votes],
            href: option_path(poll_id, option[:id])
          }
        }
      }
    end

    delete '/:id' do
      poll_id = request.captures[:id]
      repo.destroy_poll(poll_id)

      nil
    end

    post '/:id/:candidate' do
      poll_id = request.captures[:id]
      candidate_id = request.captures[:candidate]

      polls.vote(poll_id, candidate_id)

      absolute "/#{poll_id}"
    end

    private

    def repo
      @repo = PollRepository.new
    end

    def poll_path(id)
      absolute "/#{id}"
    end

    def option_path(poll_id, option_id)
      absolute "/#{poll_id}/#{option_id}"
    end
  end
end
