require_relative 'test_helper'

class CandidateTest < Minitest::Test
  def setup
    Candidate.delete_all

    Candidate.create!(name: "Alex", image_url: "http//", intelligence: 5, charisma: 6, willpower: 2, campaigns_won: 1)
    Candidate.create!(name: "Ben", image_url: "http//", intelligence: 6, charisma: 7, willpower: 4, campaigns_won: 2)
    Candidate.create!(name: "Chris", image_url: "http//", intelligence: 7, charisma: 8, willpower: 6, campaigns_won: 0)
    #Campaign.create!
  end


  def test_candidate_exists
    assert Candidate
  end

  def test_get_all_candidate
    candidates_all = Candidate.all
    assert_equal candidates_all.first["name"], "Alex"
  end



end
