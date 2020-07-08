class Movie
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :status, type: String
  field :original_id, type: Integer
  belongs_to :list
  belongs_to :user
end
