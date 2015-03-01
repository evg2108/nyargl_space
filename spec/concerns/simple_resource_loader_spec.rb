require 'rails_helper'

class TestObjectsController < ActionController::Base
  include SimpleResourceLoader
end

TestObject = Class.new(ActiveRecord::Base)

RSpec.describe SimpleResourceLoader do

  let(:name_of_controller) { TestObjectsController.controller_name }
  subject { TestObjectsController.new }

  it { expect(TestObjectsController).to be_respond_to(:per_page) }
  it { expect(TestObjectsController).to be_respond_to(:per_page=) }

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

  describe '.resource_class' do
    it 'returns class of resource' do
      expect(TestObjectsController.resource_class).to eq(TestObject)
    end
  end

  describe '.decorator_class' do
    context 'when decorator for resource is not defined' do
      it 'returns nil' do
        expect(TestObjectsController.decorator_class).to be_nil
      end
    end

    context 'when decorator for resource is defined' do
      it 'returns decorator class' do
        TestObjectDecorator = Class.new(Draper::Decorator)
        expect(TestObjectsController.decorator_class).to eq(TestObjectDecorator)
      end
    end
  end

  it 'have method with name defined by resource name' do
    is_expected.to be_respond_to(:test_object)
  end

  it 'have method with name defined by resources name' do
    is_expected.to be_respond_to(:test_objects)
  end

  describe 'single resource loading method' do
    let(:single_resource_result) { 'single resource result' }

    it 'receives single_resource method and returns they result' do
      allow(subject).to receive(:single_resource).and_return(single_resource_result)
      expect(subject.test_object).to eq(single_resource_result)
    end
  end

  describe 'plural resource loading method' do
    let(:plural_resource_result) { 'plural resources result' }

    it 'receives plural_resources method and returns they result' do
      allow(subject).to receive(:plural_resources).and_return(plural_resource_result)
      expect(subject.test_objects).to eq(plural_resource_result)
    end
  end

  describe '#page_num' do
    context 'when params not contains :page param' do
      it 'returns 1' do
        subject.params = {}
        expect(subject.page_num).to eq(1)
      end
    end

    context 'when params contains non-numerical :page param' do
      it 'returns 1' do
        subject.params = {page: 'foo'}
        expect(subject.page_num).to eq(1)
      end
    end

    context 'when params contains numerical :page param' do
      let(:page) { '42' }

      it 'returns value of :page param' do
        subject.params = {page: page}
        expect(subject.page_num).to eq(page.to_i)
      end
    end
  end
end
