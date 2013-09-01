class User < ActiveRecord::Base
  has_many :notes
  has_many :accepts
  has_many :terms_and_conditions, through: :accepts

  attr_accessor :password, :password_confirm
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_length_of :username, minimum: 6
  validates_length_of :password, minimum: 6

  def self.authentication(username, password)
    user = find_by(username: username)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def is_blocked?
    TermsAndCondition.not_accepted_by(id).any?
  end
end
