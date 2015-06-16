require 'rails_helper'

RSpec.describe Author, type: :model do
  it { is_expected.to belong_to :user }

  it { is_expected.to validate_presence_of :first_name }

  it { expect(subject.photos).to be_a Array }

  describe '#full_name' do
    context 'when only first_name exists' do
      subject { build :author }

      it 'should eq first name' do
        expect(subject.full_name).to eq(subject.first_name)
      end
    end

    context 'when only last_name and first_name exists' do
      subject { build :author, :with_last_name }

      it 'should eq last name with first name' do
        expect(subject.full_name).to eq("#{subject.last_name} #{subject.first_name}")
      end
    end

    context 'when only patronymic and first_name exists' do
      subject { build :author, :with_patronymic }

      it 'should eq first name with patronymic' do
        expect(subject.full_name).to eq("#{subject.first_name} #{subject.patronymic}")
      end
    end

    context 'when exists patronymic, first_name and last_name' do
      subject { build :author, :with_last_name, :with_patronymic }

      it 'should eq last name + first name + patronymic' do
        expect(subject.full_name).to eq("#{subject.last_name} #{subject.first_name} #{subject.patronymic}")
      end
    end
  end
end
