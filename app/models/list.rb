class List
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :type, type: String
  belongs_to :user
  belongs_to :movie
  belongs_to :show
end
