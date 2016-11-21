require_relative "test_helper"

class AppTest < Minitest::Test
  include Rack::Test::Methods


  def app
    App
  end

  def test_create_candidate
    header "content_type", "application/json"

    payload = {
      name: "Chris",
      image_url: "http//",
      intelligence: 7,
      charisma: 8,
      willpower: 6,
      campaigns_won: 0
    }

    post "/candidates", payload.to_json
    assert_equal 201, last_response.status
    assert_equal Candidate.last.id, JSON.parse(last_response.body)["id"]
    assert_equal "Chris", Candidate.last.name
  end

  def test_create_candidate_error
    header "content_type", "application/json"

    payload = {

    }

    post "/candidates", payload.to_json
    assert_equal 422, last_response.status
    assert_equal Candidate.last.id, JSON.parse(last_response.body)["id"]
    assert_equal "Chris", Candidate.last.name
  end

  def test_create_campaign
    header "content_type", "application/json"
    a = Candidate.create!(name: "Alex", image_url: "http//", intelligence: 5, charisma: 6, willpower: 2, campaigns_won: 1)
    b = Candidate.create!(name: "Ben", image_url: "http//", intelligence: 6, charisma: 7, willpower: 4, campaigns_won: 2)

    payload = {
      "candidate_one_id": a.id,
      "candidate_two_id": b.id
    }

    post "/campaign", payload.to_json
    assert_equal 201, last_response.status
    assert_equal Campaign.last.id, JSON.parse(last_response.body)["id"]
  end

  def test_can_read_all_candidates
    get "/candidates"
    assert last_response.ok?
    candidates = JSON.parse(last_response.body)
    #assert_equal 3, candidates.size
    assert_equal Candidate.last.name, candidates.last["name"]
  end

  def test_update_candidate_intelligence
    patch "/candidate/#{Candidate.last.id}/intelligence", intelligence: 8
    assert_equal 8, Candidate.last["intelligence"]
  end

  def test_update_candidate_willpower
    patch "/candidate/#{Candidate.last.id}/willpower", willpower: 6
    assert_equal 6, Candidate.last["willpower"]
  end

  def test_update_candidate_charisma
    patch "/candidate/#{Candidate.last.id}/charisma", charisma: 7
    assert_equal 7, Candidate.last["charisma"]
  end

  def test_update_candidate_name
    patch "/candidate/#{Candidate.last.id}/name", name: "Bob"
    assert_equal "Bob", Candidate.last["name"]
  end

  def test_get_specific_candidate
    response = get "/specific_candidate/#{Candidate.last.id}"
    payload = JSON.parse(response.body)

    assert_equal Candidate.last.name, payload["name"]
  end

  def test_delete_specific_candidate

    test_variable = (Candidate.last.id - 5)
    delete "/candidate/#{Candidate.last.id}"

    assert_equal test_variable + 4, Candidate.last.id
  end

  def test_get_campaigns_for_specific_candidate
    header "content_type", "application/json"


    a = Candidate.create!(name: "Alex", image_url: "http//", intelligence: 5, charisma: 6, willpower: 2, campaigns_won: 1)
    b = Candidate.create!(name: "Ben", image_url: "http//", intelligence: 6, charisma: 7, willpower: 4, campaigns_won: 2)

    payload = {
      "candidate_one_id": a.id,
      "candidate_two_id": b.id
    }

    post "/campaign", payload.to_json
    post "/campaign", payload.to_json


    response = get "/campaigns/candidate/#{a.id}"
    payload = JSON.parse(response.body)

    assert_equal Campaign.last.id, payload.map{|x| x["id"]}
  end

end
