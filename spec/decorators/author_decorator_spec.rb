require 'rails_helper'

RSpec.describe AuthorDecorator do
  describe '#full_name' do
    let(:author) { FactoryGirl.create(:author).decorate }

    it 'returns string with first name, last name and patronymic' do
      expect(author.full_name).to eq("#{author.last_name} #{author.first_name} #{author.patronymic}")
    end
  end
end
