require 'active_support/concern'

module CreationPrivacyPolicyAcceptedCheck
  extend ActiveSupport::Concern

  included do
    validate :is_privacy_policy_accepted?, on: :create
    attr_accessor :privacy_policy_accepted
  end

  def is_privacy_policy_accepted?
    errors.add(:privacy_policy_accepted, I18n.t('errors.messages.accepted')) unless privacy_policy_accepted == '1'
  end

end
