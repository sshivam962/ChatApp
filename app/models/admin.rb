class Admin < ApplicationRecord
  before_save {self.email = email.downcase}
  after_save do
    self.hobby_id.reject(&:blank?)
  end
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true
end
