require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  default_values = { title: 'Ein Zuhause', description: 'Erwartet Dich', to_date: '29-09-2019', from_date: '29-11-2019',
                     gender: 0, no_spam: '1', owner_name: 'Owner', email: 'owner@example.com', privacy_policy_accepted: '1' }

  test 'default_values work' do
    request = Request.new(default_values)
    request.save!
  end

  test 'must have title' do
    request = Request.new(default_values.except(:title))
    assert_not request.save
  end

  test 'must have description' do
    request = Request.new(default_values.except(:description))
    assert_not request.save
  end

  test 'can have to_date' do
    request = Request.new(default_values.except(:to_date))
    request.save!
  end

  test 'can have from_date' do
    request = Request.new(default_values.except(:from_date))
    request.save!
  end

  test 'must have gender' do
    request = Request.new(default_values)
    request.gender = nil
    assert_not request.save
  end

  test 'must have owner_name' do
    request = Request.new(default_values.except(:owner_name))
    assert_not request.save
  end

  test 'must have email' do
    request = Request.new(default_values.except(:email))
    assert_not request.save
  end

  test 'must have privacy policy accepted' do
    request = Request.new(default_values.except(:privacy_policy_accepted))
    assert_not request.save
  end

  test 'title can have 140 characters' do
    request = Request.new(default_values.except(:title))
    request.title = 'a' * 140
    assert request.save
  end

  test "title can't be longer than 140 characters" do
    request = Request.new(default_values.except(:title))
    request.title = 'a' * 141
    assert_not request.save
  end

end