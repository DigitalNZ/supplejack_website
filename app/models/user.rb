class User < ActiveRecord::Base
  include ApiUser
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


	validates_uniqueness_of :username, allow_blank: true, if: :username_changed?

  def to_s
  	self.name
  end
end
