require 'real_time/db'

module RealTime
  class PollRepository
    POLLS_TABLE = :polls
    CANDIDATES_TABLE = :candidates

    def initialize(database = DB)
      @poll_dataset = database.from(POLLS_TABLE)
      @candidate_dataset = database.from(CANDIDATES_TABLE)
    end

    def all
      @poll_dataset.all
    end

    def find(id)
      @poll_dataset[id: id]
    end

    def create(poll)
      id = @poll_dataset.insert(poll)
      poll.merge(id: id)
    end

    def destroy(poll_id)
      @poll_dataset.where(id: poll_id).delete
    end

    # Atomic update
    def vote(candidate)
    end
  end
end
