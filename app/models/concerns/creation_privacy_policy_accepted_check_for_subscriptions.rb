require 'active_support/concern'

module CreationPrivacyPolicyAcceptedCheckForSubscriptions
  extend ActiveSupport::Concern

  included do
    validate :is_privacy_policy_accepted?, on: :create
  end

  def is_privacy_policy_accepted?
    errors.add(I18n.t('privacy.policy'), I18n.t('errors.messages.accepted')) unless privacy_policy_accepted == true
  end

end
