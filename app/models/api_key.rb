# ApiKey
class ApiKey < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :token, :user_id
end
