class User < ApplicationRecord
  belongs_to :user

  validates_presence_of :token, :user_id
end
