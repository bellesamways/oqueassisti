class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  include ActiveModel::SecurePassword

  VALID_EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i.freeze

  field :name, type: String
  field :email, type: String
  field :username, type: String
  field :password_digest, type: String

  attr_accessor :old_password

  has_secure_password

  validates :name, presence: true, length: { minimum: 1 }
  validates :username, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 260 }, format: { with: VALID_EMAIL_FORMAT }, uniqueness: { case_sensitive: false }

  validate :update_validate, on: %i[update update_password]

  embeds_many :lists

  before_save do
    self.email = email.downcase
    self.username = username.downcase
  end

  def update_validate
    return errors.add(:old_password, 'A senha é nula.') if old_password.blank?

    return if BCrypt::Password.new(password_digest_was) == old_password

    errors.add(:old_password, 'A senha antiga está incorreta.')
  end
end
