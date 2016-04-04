# User
class User < ActiveRecord::Base
  include ApiUser
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:username]

	validates_presence_of   :username
	validates_uniqueness_of :username, allow_blank: true, if: :username_changed?

	validates_acceptance_of :terms_of_service

  def to_s
  	self.name
  end
end
