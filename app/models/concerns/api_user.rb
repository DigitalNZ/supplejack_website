# frozen_string_literal: true

module ApiUser
  extend ActiveSupport::Concern

  included do
    has_one :key, class_name: 'ApiKey', dependent: :destroy

    # api_key is defined here because user.api_key is used everywhere
    # from when api_keys was a has_many
    delegate :token, to: :key
    alias_method :api_key, :token
  end

  # ClassMethod
  module ClassMethods
    def find_by_api_key(api_key)
      joins(:key).where(api_keys: { token: api_key }).first
    end
  end

  def create_supplejack_record
    record = UserRecord.create(supplejack_record_params, user.api_key)
    update_attribute(:record_id, record.record_id)
  rescue RestClient::Exception => e
    Rails.logger.error(e.message)
    Rails.logger.error(e.backtrace)
    raise ActiveRecord::Rollback
  end

  def update_api_user
    Supplejack::User.update(name: name, username: username, email: email, encrypted_password: encrypted_password, api_key: api_key)
  end

  def user
    @user ||= Supplejack::User.find(token)
  end

  def regenerate_key!
    user.regenerate_api_key = true
    user.save
    create_key(token: user.api_key, terms: false)
    @user = nil
  end

  def latest_sets
    return @latest_sets if @latest_sets

    @latest_sets = begin
                     dnz_user.sets.order(:updated_at)
                   rescue StandardError
                     nil
                   end
    @latest_sets ||= []
    @latest_sets = @latest_sets[0..4] if @latest_sets.try(:any?)
    @latest_sets
  end

  def accepted_terms?
    key&.terms
  end
end
