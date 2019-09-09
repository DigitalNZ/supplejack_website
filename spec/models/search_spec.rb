require 'rails_helper'

RSpec.describe Search do

  let(:search) { Search.new }

  describe '#initialize' do
    it 'should set the category if tab is present' do
      @search = Search.new(tab: 'nz')
      @search.and.should_not be_nil
    end
  end
end
