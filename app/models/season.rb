class Season
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :original_id, type: Integer
  field :overview, type: String
  field :season_number, type: Integer

  has_many :episodes
  belongs_to :show
end
