require 'real_time/db'

module RealTime
  class PollRepository
    POLLS_TABLE = :polls
    CANDIDATES_TABLE = :candidates

    def initialize(database = DB)
      @poll_dataset = database.from(POLLS_TABLE)
      @candidate_dataset = database.from(CANDIDATES_TABLE)
    end

    def all_polls
      @poll_dataset.all
    end

    def find_poll(id)
      @poll_dataset[id: id]
    end

    def find_poll_options(poll_id)
      @candidate_dataset.where(poll_id: poll_id).all
    end

    def create_poll(poll_name, candidate_names)
      poll_id = @poll_dataset.insert(name: poll_name)
      candidate_names.each do |name|
        @candidate_dataset.insert(name: name, poll_id: poll_id)
      end

      poll_id
    end

    def destroy_poll(poll_id)
      @candidate_dataset.where(poll_id: poll_id).delete
      @poll_dataset.where(id: poll_id).delete
    end

    # Atomic update
    def vote(poll_id, candidate_id)
      @candidate_dataset.where(poll_id: poll_id, id: candidate_id).update(votes: Sequel.expr(:votes) + 1)
    end
  end
end
