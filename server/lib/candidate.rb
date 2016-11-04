require "active_record"

class Candidate < ActiveRecord::Base
  has_many :winning_candidate_id, class_name: "Campaign", foreign_key: :winning_candidate_id
  #  has_many :losing_candidate_id, class_name: "Campaign", foreign_key: :losing_candidate_id_id
  #validates :url, format: { with: /\A(http|https):\/\// }
  ####validates url_img will work based on png/jpg ending



end
