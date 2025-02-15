class Offer < ApplicationRecord
  include Item
  include CreationPrivacyPolicyAcceptedCheck

  validates_presence_of :title, :description, :from_date, :rent, :size, :gender, :zip_code, :district
  validates_length_of :title, maximum: 140

  enum gender: { dontcare: 0, female: 1, male: 2 }
end
