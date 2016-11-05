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

    post "/candidate", payload.to_json
    assert_equal 201, last_response.status
    assert_equal Candidate.last.id, JSON.parse(last_response.body)["id"]
    assert_equal "Chris", Candidate.last.name
  end

  focus
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

    p JSON.parse(last_response.body)
  end

  def test_can_read_all_candidates
    get "/candidates"
    assert last_response.ok?
    candidates = JSON.parse(last_response.body)
    #assert_equal 3, candidates.size
    assert_equal "Alex", candidates.first["name"]
  end

  def test_update_candidate
    skip
    response = patch "/candidate?name=Chris&name_update=Obama"
    payload = JSON.parse(response.body)
    assert_equal "Obama", payload["name"]
  end

  def test_get_specific_candidate
    skip
    response = get "/specific_candidate?name=Alex"
    payload = JSON.parse(response.body)

    assert_equal "Alex", payload["name"]
  end

  def test_delete_specific_candidate
    skip
    delete "/candidate?id=35"


    assert_equal nil, Candidate.all
  end

end
