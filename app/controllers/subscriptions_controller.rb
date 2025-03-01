class SubscriptionsController < ApplicationController

  before_action :check_offers_or_requests, only: [:create]
  before_action :authenticate_user!, only: [:unsubscribe_user]

  def create
    @subscription = Subscription.find_or_create_by(email: subscription_params[:email], privacy_policy_accepted: subscription_params[:privacy_policy_accepted])
    @subscription.no_spam = subscription_params[:no_spam]
    @subscription.offers = true if subscription_params[:offers] == 'true'
    @subscription.requests = true if subscription_params[:requests] == 'true'
    @subscription.privacy_policy_accepted = true if subscription_params[:privacy_policy_accepted] == 'true'
    if subscription_params[:spam] == 'true'
      ip = request.remote_ip
      logger.debug "Blocking #{ip}"
      Rack::Attack.cache.write("block #{ip}", true, 30.days)
      return
    end
    if @subscription.changed?
      unless @subscription.save
        filtered_full_messages = @subscription.errors.select { |error| error.type != :taken }.map { |error| error.full_message }
        redirect_back(fallback_location: root_path, flash: { error: t('subscriptions.subscribe.error_save') + ' ' + filtered_full_messages.join('. ') + '.' })
        return
      end
      if @subscription.confirmed?
        SubscriptionMailer.subscribe_notification(@subscription).deliver_now unless user_signed_in?
        redirect_back(fallback_location: root_path, notice: t('subscriptions.subscribe.success.confirmed'))
        return
      end
    end
    if user_signed_in? && current_user.email == @subscription.email
      if current_user.confirmed?
        @subscription.confirm!
        redirect_back(fallback_location: root_path)
      else
        redirect_back(fallback_location: root_path, notice: t('subscriptions.subscribe.success.unconfirmed_user'))
      end
    elsif @subscription.confirmed?
      redirect_back(fallback_location: root_path, notice: t('subscriptions.subscribe.success.unconfirmed'))
      return
    else
      SubscriptionMailer.confirmation_request(@subscription).deliver_now
      redirect_back(fallback_location: root_path, notice: t('subscriptions.subscribe.success.unconfirmed'))
    end
  end

  def unsubscribe_user
    @subscription = Subscription.find_by_email(current_user.email)
    unless @subscription
      redirect_back(fallback_location: root_path, flash: { error: t('subscriptions.unsubscribe.not_subscribed') })
      return
    end
    @subscription.offers = false if subscription_params[:offers] == 'true'
    @subscription.requests = false if subscription_params[:requests] == 'true'
    if @subscription.offers || @subscription.requests
      @subscription.save! if @subscription.changed?
    else
      @subscription.destroy
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @subscription = Subscription.find_by_unsubscribe_token(params[:unsubscribe_token])
    unless @subscription
      redirect_to root_path, flash: { error: t('subscriptions.unsubscribe.bad_token') }
      return
    end
    case params[:item_type]
    when 'offers'
      @subscription.offers = false
    when 'requests'
      @subscription.requests = false
    when 'all'
      @subscription.offers = false
      @subscription.requests = false
    else
      redirect_to root_path, flash: { error: t('subscriptions.unsubscribe.bad_item_type') }
      return
    end
    if @subscription.offers || @subscription.requests
      @subscription.save! if @subscription.changed?
    else
      @subscription.destroy
    end
    unless user_signed_in?
      SubscriptionMailer.unsubscribe_notification(@subscription).deliver_now
    end
    redirect_to root_path, notice: t('subscriptions.unsubscribe.success')
  end

  def confirm
    @subscription = Subscription.find_by(confirmation_token: params[:confirmation_token])
    @subscription or return redirect_to root_path, flash: { error: t('subscriptions.activation.bad_token') }
    @subscription.confirm!
    redirect_to root_path, notice: t('subscriptions.activation.success')
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def subscription_params
    params[:subscription].permit(:email, :offers, :requests, :no_spam, :spam, :privacy_policy_accepted)
  end

  def check_offers_or_requests
    unless subscription_params[:offers] == 'true' || subscription_params[:requests] == 'true' || subscription_params[:spam] == 'true'
      redirect_back(fallback_location: root_path, flash: { error: t('subscriptions.subscribe.nothing_selected') })
    end
  end

end
