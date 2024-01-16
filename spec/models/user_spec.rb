# frozen_string_literal: true

RSpec.describe User do
  let(:user) { build(:user) }

  describe 'validations' do
    it 'is valid from the factory' do
      expect(user).to be_valid
    end

    it 'is invalid without an email' do
      user.email = nil

      expect(user).not_to be_valid
    end

    it 'is invalid without a password' do
      user.password = nil

      expect(user).not_to be_valid
    end

    it 'is invalid with a password that is too short' do
      user.password = '!long'

      expect(user).not_to be_valid
    end

    it 'is invalid if the email already exists in the database' do
      user.save
      new_user = build(:user, email: user.email)
      expect(new_user).not_to be_valid
    end
  end
end
