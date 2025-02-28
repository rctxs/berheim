require 'active_support/concern'

module CreationPrivacyPolicyAcceptedCheck
  extend ActiveSupport::Concern

  included do
    validate :is_privacy_policy_accepted?, on: :create
  end

  def is_privacy_policy_accepted?
    errors.add(:privacy_policy_accepted, I18n.t('errors.messages.accepted')) unless privacy_policy_accepted == true
  end

end
