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

  post "/candidate" do
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

  post "/campaign" do
    text = request.body.read
    campaign_info = JSON.parse(text)
    content_type("application/json")

    # Lookup candidate ids in the db
    first_candidate = Candidate.find_by(id: campaign_info["candidate_one_id"])
    second_candidate = Candidate.find_by(id: campaign_info["candidate_two_id"])

    campaign = Campaign.new
    campaign.winning_candidate_id = first_candidate.id
    campaign.losing_candidate_id = second_candidate.id

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

  get "/candidates" do
    content_type("application/json")
    Candidate.all.to_json
  end

  get "/specific_candidate" do
    content_type "application/json"
    Candidate.find_by(name: params["name"]).to_json
  end

  get "/campaigns" do
    content_type "application/json"
    Campaign.all.to_json
  end

  patch "/candidate" do
    content_type "application/json"
    Candidate.find_by(name: params["name"]).update(name: params["name_update"])
  end

  delete "/candidate" do
    content_type "application/json"
    a = Candidate.where(id: params["id"])
    a.delete_all
  end




  # If this file is run directly boot the webserver
  run! if app_file == $PROGRAM_NAME
end
