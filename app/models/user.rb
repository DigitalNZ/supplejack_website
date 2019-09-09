class User < ApplicationRecord
  include ApiUser

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_supplejack_user

  def create_supplejack_user
    user = Supplejack::User.create(
      email: self.email,
      name: self.name,
      username: self.username,
      encrypted_password: self.encrypted_password,
      sets: [{ name: "Favourites", privacy: "hidden", priority: 0 }]
    )
    self.create_key(token: user.api_key, terms: false)
  rescue StandardError => e
    byebug
    Rails.logger.warn("There was a error when creating the API User and default set for member: #{self.id}. Error: #{e.message}")
    self.errors.add(:base, I18n.t('registration.account_creation_error'))
    raise ActiveRecord::Rollback
  end
end
