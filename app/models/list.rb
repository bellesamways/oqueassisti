class List
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :type, type: String

  embedded_in :user

  has_and_belongs_to_many :movies
  has_and_belongs_to_many :shows
end
