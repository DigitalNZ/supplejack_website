# frozen_string_literal: true

class ApiKey < ApplicationRecord
  belongs_to :user

  validates_presence_of :token, :user_id
end
