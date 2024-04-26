class SubscriptionMailer < ActionMailer::Base
  default from: "Berheim <no-reply@berheim.smd.berlin>"

  def confirmation_request subscription
    @subscription = subscription
    mail to: subscription.email, subject: default_i18n_subject
  end

  def unsubscribe_notification subscription
    @subscription = subscription
    mail to: subscription.email, subject: default_i18n_subject
  end

  def subscribe_notification subscription
    @subscription = subscription
    mail to: subscription.email, subject: default_i18n_subject
  end

  def new_item_notification item, subscriber
    @item = item
    @subscriber = subscriber
    mail to:subscriber.email, subject: default_i18n_subject
  end
end
