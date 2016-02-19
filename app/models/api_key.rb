class ApiKey < ActiveRecord::Base
  belongs_to :user

  validates :token, :user_id, presence: true
end
