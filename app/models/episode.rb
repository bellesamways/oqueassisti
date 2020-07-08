class Episode
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :status, type: String
  field :original_id, type: Integer
  belongs_to :season
  belongs_to :show
end
