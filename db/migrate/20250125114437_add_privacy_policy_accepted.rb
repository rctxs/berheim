class AddPrivacyPolicyAccepted < ActiveRecord::Migration[6.1]
  def change
    add_column :offers, :privacy_policy_accepted, :boolean, null: false, default: false
    add_column :requests, :privacy_policy_accepted, :boolean, null: false, default: false
    add_column :answers, :privacy_policy_accepted, :boolean, null: false, default: false
    add_column :subscriptions, :privacy_policy_accepted, :boolean, null: false, default: false
    change_column_default :offers, :privacy_policy_accepted, from: false, to: nil
    change_column_default :requests, :privacy_policy_accepted, from: false, to: nil
    change_column_default :answers, :privacy_policy_accepted, from: false, to: nil
    change_column_default :subscriptions, :privacy_policy_accepted, from: false, to: nil
  end
end
