require 'test_helper'

class OfferTest < ActiveSupport::TestCase

  default_values = { title: 'Ein Zuhause', description: 'Erwartet Dich', from_date: '29-09-2019', rent: 250, size: 14,
                     gender: 0, street: 'Wilhelmshavener Str. 4', district: 'Moabit', zip_code: '10551', owner_name: 'Owner', email: 'owner@example.com', privacy_policy_accepted: true }

  test 'default_values work' do
    offer = Offer.create(default_values)
    offer.save!
  end

  test 'must have title' do
    offer = Offer.new(default_values.except(:title))
    assert_not offer.save
  end

  test 'must have description' do
    offer = Offer.new(default_values.except(:description))
    assert_not offer.save
  end

  test 'must have from_date' do
    offer = Offer.new(default_values.except(:from_date))
    assert_not offer.save
  end

  test 'must have size' do
    offer = Offer.new(default_values.except(:size))
    assert_not offer.save
  end

  test 'must have gender' do
    offer = Offer.new(default_values)
    offer.gender = nil
    assert_not offer.save
  end

  test 'must have district' do
    offer = Offer.new(default_values.except(:district))
    assert_not offer.save
  end

  test 'must have zip_code' do
    offer = Offer.new(default_values.except(:zip_code))
    assert_not offer.save
  end

  test 'must have owner_name' do
    offer = Offer.new(default_values.except(:owner_name))
    assert_not offer.save
  end

  test 'must have email' do
    offer = Offer.new(default_values.except(:email))
    assert_not offer.save
  end

  test 'must have privacy policy accepted' do
    offer = Offer.new(default_values.except(:privacy_policy_accepted))
    assert_not offer.save
  end

  test 'must have privacy policy accepted to be true' do
    request = Offer.new(default_values)
    request.privacy_policy_accepted = false
    assert_not request.save
  end

  test 'title can have 140 characters' do
    offer = Offer.new(default_values.except(:title))
    offer.title = 'a' * 140
    assert offer.save
  end

  test "title can't be longer than 140 characters" do
    offer = Offer.new(default_values.except(:title))
    offer.title = 'a' * 141
    assert_not offer.save
  end

end