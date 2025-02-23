require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase

  test 'create with privacy policy accepted and no spam works' do
    subscription = Subscription.create({ email: 'test@example.com', privacy_policy_accepted: true, no_spam: '1' })
    subscription.save!
  end

  test 'must have privacy policy accepted' do
    subscription = Subscription.create({ email: 'test@example.com', no_spam: '1' })
    assert_not subscription.save
  end

  test 'must have privacy policy accepted to be true' do
    subscription = Subscription.create({ email: 'test@example.com', privacy_policy_accepted: false, no_spam: '1' })
    assert_not subscription.save
  end

  test 'confirm! confirmes' do
    subscription = subscriptions(:unconfirmed)
    subscription.confirm!
    assert subscription.confirmed?
  end

  test 'confirmed if token is nil' do
    subscription = Subscription.create({ email: 'test@example.com' })
    subscription.confirmation_token = nil
    assert subscription.confirmed?
  end

  test 'not confirmed if token is not empty' do
    subscription = Subscription.create({ email: 'test@example.com' })
    subscription.confirmation_token = '123'
    assert_not subscription.confirmed?
  end

  test 'not confirmed if just created' do
    subscription = Subscription.create({ email: 'test@example.com' })
    assert_not subscription.confirmed?
  end

  test 'unsubscribe token is generated' do
    subscription = Subscription.create({ email: 'test@example.com' })
    assert_not_empty subscription.unsubscribe_token
  end

  test 'cannot save second subscription with same unsubscribe token' do
    subscription1 = Subscription.create({ email: 'one@example.com', privacy_policy_accepted: true, no_spam: '1' })
    subscription2 = Subscription.create({ email: 'another@example.com', privacy_policy_accepted: true, no_spam: '1' })
    subscription2.unsubscribe_token = subscription1.unsubscribe_token
    assert_not subscription2.save
  end

  test 'user without confirmation token is confirmed' do
    subscriber = subscriptions(:offer_subscriber)
    assert subscriber.confirmed?
  end

end