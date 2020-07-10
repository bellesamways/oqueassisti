class Episode
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :original_id, type: Integer
  field :overview, type: String
  field :episode_number, type: Integer
  field :season_number, type: Integer

  belongs_to :season
end
