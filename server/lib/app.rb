# This is used to select which database to use.
ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
require 'sinatra'
require 'json'

require_relative 'database'
require_relative 'candidate'
require_relative 'campaign'


class App < Sinatra::Base
  # Serve any HTML/CSS/JS from the client folder
  set :static, true
  set :public_folder, proc { File.join(root, '..', '..', 'client', 'public') }

  # Enable the session store
  enable :sessions

  # This ensures that we always return the content-type application/json
  before do
    content_type 'application/json'
  end

  # DO NOT REMOVE THIS ENDPOINT IT ENABLES HOSTING HTML FOR THE FRONT END
  get '/' do
    content_type 'text/html'
    body File.read(File.join(settings.public_folder, 'index.html'))
  end

  # You can delete this route but you should nest your endpoints under /api
  get '/api' do
    { msg: 'The server is running' }.to_json
  end

  #add candidate
  post "/candidates" do
    text = request.body.read
    candidate_info = JSON.parse(text)
    content_type("application/json")
    candidate = Candidate.new(candidate_info)

    if candidate.save
      status 201
      candidate.to_json
    else
      status 422
      {
        errors: {
          full_messages: candidate.errors.full_messages,
          messages: candidate.errors.messages
        }
      }.to_json
    end
  end

  #add campaign....when a campaign is will take in two canidates and "run" a -
  # - campaign to see who won and produce a winner or loser.
  post "/campaign" do
    text = request.body.read
    campaign_info = JSON.parse(text)
    content_type("application/json")

    # Lookup candidate ids in the db
    first_candidate = Candidate.find_by(id: campaign_info["candidate_one_id"])
    second_candidate = Candidate.find_by(id: campaign_info["candidate_two_id"])

    array_of_candidates = [first_candidate, second_candidate]
    winner = array_of_candidates.sample
    array_of_candidates.delete(winner)
    loser = array_of_candidates.sample

    campaign = Campaign.new
    campaign.winning_candidate_id = winner.id
    campaign.losing_candidate_id = loser.id

    if campaign.save
      status 201
      campaign.to_json
    else
      status 422
      {
        errors: {
          full_messages: campaign.errors.full_messages,
          messages: campaign.errors.messages
        }
      }.to_json
    end
  end

  #gets all candidates
  get "/candidates" do
    content_type("application/json")
    Candidate.all.to_json
  end

  #gets specific candidate by id
  get "/specific_candidate/:id" do
    content_type "application/json"
    Candidate.find_by(id: params["id"]).to_json
  end

  #change a specific candidate intelligence. the candidate is chosen by id
  patch "/candidate/:id/intelligence" do
    content_type "application/json"
    Candidate.find_by(id: params["id"]).update(intelligence: params["intelligence"])
  end

  #change a specific candidate willpower. the candidate is chosen by id
  patch "/candidate/:id/willpower" do
    content_type "application/json"
    Candidate.find_by(id: params["id"]).update(willpower: params["willpower"])
  end

  #change a specific candidate charisma. the candidate is chosen by id
  patch "/candidate/:id/charisma" do
    content_type "application/json"
    Candidate.find_by(id: params["id"]).update(charisma: params["charisma"])
  end

  #change a specific candidate name. the candidate is chosen by id
  patch "/candidate/:id/name" do
    content_type "application/json"
    Candidate.find_by(id: params["id"]).update(name: params["name"])
  end

  #change a specific candidate image_url. the candidate is chosen by id
  patch "/candidate/:id/image_url" do
    content_type "application/json"
    Candidate.find_by(id: params["id"]).update(image_url: params["update"])
  end

  #delete a specific candidate chosen by id
  delete "/candidate/:id" do
    candidate = Candidate.find_by(id: params["id"])
    if candidate
      candidate.delete
    else
      status 404
      {message: "Candidate with id ##{params["id"]} does not exist"}.to_json
    end
  end

  #gets all campaigns
  get "/campaigns" do
    content_type "application/json"
    Campaign.all.to_json
  end

  #get all campaigns for specific candidate
  get "/campaigns/candidate/:id" do
    #first_candidate = Candidate.find_by(id: campaign_info["candidate_id"])
    #columns = [:winning_candidate_id,:]
    content_type "application/json"
    Campaign.where(winning_candidate_id: params["id"]).or(Campaign.where(losing_candidate_id: params["id"])).to_json
  end

  # If this file is run directly boot the webserver
  run! if app_file == $PROGRAM_NAME
end
