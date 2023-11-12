# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates :password, length: { minimum: 12 }

  def generate_auth_token
    Authentication::Token.generate(user: self)
  end
end
