# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  token           :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :username, :email, :password_digest, :token, :presence => true
  validates :password, :length => { minimum: 6, allow_nil: true }
  validates :username, :token, :uniqueness => true

  before_validation :set_token

  attr_reader :password

  has_many :clients
  has_many :projects, through: :clients


  def self.generate_token
    SecureRandom.urlsafe_base64(16)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end

  def open_projects
    self.projects.where(:open => true)
  end

  def closed_projects
    self.projects.where(:open => false)
  end


  def reset_token!
    self.token = User.generate_token
    self.save!
    self.token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  private

    def set_token
      self.token ||= User.generate_token
    end

end
