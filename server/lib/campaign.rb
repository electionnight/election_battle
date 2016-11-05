require "active_record"

class Campaign < ActiveRecord::Base
    belongs_to :winning_candidate, class_name: "Candidate", foreign_key: :winning_candidate_id
    belongs_to :losing_candidate, class_name: "Candidate", foreign_key: :losing_candidate_id

    def assign_winning_candidate(new_candidate)
      self["winning_candidate_id"] = new_candidate["id"]
      self.save
    end

    def assign_losing_candidate(new_candidate)
      self["losing_candidate_id"] = new_candidate["id"]
      self.save
    end

    def assign_winner_and_loser_candidate(winner, loser)
      assign_winning_candidate(winner)
      assign_losing_candidate(loser)
    end
end
