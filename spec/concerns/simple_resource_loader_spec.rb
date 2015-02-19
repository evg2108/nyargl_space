require 'rails_helper'

class TestObjectsController < ActionController::Base
  include SimpleResourceLoader

  def params
    {controller: 'tests', action: 'index'}
  end
end

RSpec.describe SimpleResourceLoader do

  let(:name_of_controller) { TestObjectsController.controller_name }
  let(:simple_resource_loader) { TestObjectsController.new }

  describe '.resource_name' do
    it 'returns singularized and symbolized string received from controller_name method' do
      expect(TestObjectsController.resource_name).to eq(name_of_controller.singularize.to_sym)
    end
  end

  describe '.resources_name' do
    it 'returns symbolized string received from controller_name method' do
      expect(TestObjectsController.resources_name).to eq(name_of_controller.to_sym)
    end
  end

  it 'have method with name defined by resource name' do
    expect(simple_resource_loader).to be_respond_to(:test_object)
  end

  it 'have method with name defined by resources name' do
    expect(simple_resource_loader).to be_respond_to(:test_objects)
  end
end
