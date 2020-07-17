class Show
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :status, type: String
  field :original_id, type: Integer
  field :original_title, type: String
  field :networks, type: Array

  has_many :seasons
  has_and_belongs_to_many :list
end
