require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create :user }

  it { is_expected.to be_a(Roles) }

  it { is_expected.to have_one(:author).dependent(:destroy) }
  it { is_expected.to have_many(:products).dependent(:nullify) }

  it { is_expected.to have_secure_password }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }

  it { is_expected.to validate_presence_of(:password_digest) }

  describe '#email' do
    context 'when have email format' do
      let(:user) { build :user }

      it ' should be valid' do
        expect(user).to be_valid
      end
    end

    context 'when not have email format' do
      let(:user) { build :user, :with_bad_email }

      it ' should not be valid' do
        expect(user).not_to be_valid
      end
    end
  end

  describe 'when saved and role not set' do
    let(:user) { create :user }

    it 'should have default role' do
      expect(user.role).to eq(Roles.default_role)
    end
  end

  describe 'when not saved and role not set' do
    let(:user) { build :user }

    it 'should have default role' do
      expect(user.role).to eq(Roles.default_role)
    end
  end
end
