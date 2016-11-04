require_relative 'test_helper'

class CampaignTest < Minitest::Test
  def setup


    Campaign.create!

  end

##SS

  def test_campaign_exists
    assert Campaign
  end

  def test_get_all_campaign
    candidates_all = Campaign.all
    assert_equal candidates_all.first["id"], 1
  end

  def test_assigning_winning_candidate_to_campaign
    new_candidate = Candidate.create!(name: "Dude", image_url: "http//", intelligence: 7, charisma: 1, willpower: 6, campaigns_won: 0)

    b = Campaign.create!

    b.assign_winning_candidate(new_candidate)
    assert_equal b["winning_candidate_id"], new_candidate["id"]
  end

  def test_assigning_losing_candidate_to_campaign
    new_candidate = Candidate.create!(name: "Jeff", image_url: "http//", intelligence: 3, charisma: 5, willpower: 1, campaigns_won: 0)

    b = Campaign.create!

    b.assign_losing_candidate(new_candidate)
    assert_equal b["losing_candidate_id"], new_candidate["id"]
  end

  def test_assigning_winner_and_loser_to_campaign
    winner_candidate = Candidate.create!(name: "Jeff", image_url: "http//", intelligence: 3, charisma: 5, willpower: 1, campaigns_won: 0)
    loser_candidate = Candidate.create!(name: "Alex", image_url: "http//", intelligence: 4, charisma: 1, willpower: 7, campaigns_won: 0)

    b = Campaign.create!

    b.assign_winner_and_loser_candidate(winner_candidate, loser_candidate)
    assert_equal b["winning_candidate_id"], winner_candidate["id"]
    assert_equal b["losing_candidate_id"], loser_candidate["id"]
  end


end
