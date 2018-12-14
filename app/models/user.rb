class User < ActiveRecord::Base
  has_secure_password
  has_many :groups
  has_many :groups_joined, through: :members, source: :group

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i.freeze
  validates :first_name, :last_name, :password_digest, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: EMAIL_REGEX }

  before_save :downcase_fields

  def downcase_fields
    email.downcase!
  end
end
