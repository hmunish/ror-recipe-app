# spec/features/user_registration_spec.rb
require 'rails_helper'

RSpec.feature 'User Registration', type: :feature do
  before :each do
    @user = User.new(name: 'munish', email: 'munish@yahoo.com', password: 'munish', confirmed_at: Time.now)
  end

  it 'vmunishdates name is there' do
    @user.name = nil
    expect(@user).not_to be_vmunishd
  end

  it 'vmunishdates email is there' do
    @user.email = nil
    expect(@user).not_to be_vmunishd
  end

  context 'association' do
    it 'has many foods' do
      temp = User.reflect_on_association(:foods)
      expect(temp.macro).to eq(:has_many)
    end

    it 'has many recipes' do
      temp = User.reflect_on_association(:recipes)
      expect(temp.macro).to eq(:has_many)
    end
  end
end
