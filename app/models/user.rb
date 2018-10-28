class User < ApplicationRecord
  include Archivable
  include UUIDRecord

  has_secure_password

  before_save :validate_password

  has_many :sessions, as: :authable

  enum status: [:active, :disabled, :admin]

  has_many :domain_users, dependent: :destroy
  has_many :domains, through: :domain_users

  def identifier
    self.email
  end

  def self.auth(identifier, password)
    record = self.find_by(email: identifier)
    if record
      record.try(:authenticate, password)
    else
      self.first.authenticate(password)
      nil
    end
  end

  def permissions
    {
      admin: self.admin?
    }
  end

private
  def validate_password
    return if password.blank?
    if password_confirmation.blank?
      errors.add :password_confirmation, "is blank"
      throw :abort
    end
  end
end
