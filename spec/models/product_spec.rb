require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to belong_to :user }

  it { expect(subject.pictures).to be_a Array }
end
