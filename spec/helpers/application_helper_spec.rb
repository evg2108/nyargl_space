require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe '#current_asset_name' do
    let(:test_controller_name) { controller_path }
    let(:test_action_name) { 'test_action_name' }

    it 'returns path to asset using controller_path and action_name' do
      allow(helper).to receive(:action_name).and_return(test_action_name)
      expect(helper.current_asset_name).to eq("application/#{test_controller_name}/#{test_action_name}")
    end
  end
end