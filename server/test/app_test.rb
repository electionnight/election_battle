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

  def test_can_read_all_candidates
    get "/candidates"
    assert last_response.ok?
    candidates = JSON.parse(last_response.body)
    #assert_equal 3, candidates.size
    assert_equal "Alex", candidates.first["name"]
  end

  def test_update_candidate
    response = patch "/candidates?name=Alex&name_update=Obama"
    #payload = JSON.parse(response.body)
    assert_equal "Obama",response.body
  end

  def test_get_specific_candidate
    skip
    response = get "/specific_candidate?name=Ben"
    payload = JSON.parse(response.body)
    assert_equal "Ben", payload["name"]
  end

end
