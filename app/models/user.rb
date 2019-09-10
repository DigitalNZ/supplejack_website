# frozen_string_literal: true

class User < ApplicationRecord
  include ApiUser

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_supplejack_user

  def create_supplejack_user
    user = Supplejack::User.create(
      email: email,
      name: name,
      username: username,
      encrypted_password: encrypted_password,
      sets: [{ name: 'Favourites', privacy: 'hidden', priority: 0 }]
    )
    create_key(token: user.api_key, terms: false)
  rescue StandardError => e
    Rails.logger.warn("There was a error when creating the API User and default set for member: #{id}. Error: #{e.message}")
    errors.add(:base, I18n.t('registration.account_creation_error'))
    raise ActiveRecord::Rollback
  end
end
