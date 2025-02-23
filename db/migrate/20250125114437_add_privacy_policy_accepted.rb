class AddPrivacyPolicyAccepted < ActiveRecord::Migration[6.1]
  def change
    add_column :offers, :privacy_policy_accepted, :boolean, null: false
    add_column :requests, :privacy_policy_accepted, :boolean, null: false
    add_column :answers, :privacy_policy_accepted, :boolean, null: false
    add_column :subscriptions, :privacy_policy_accepted, :boolean, null: false
  end
end
