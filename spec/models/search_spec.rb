require 'rails_helper'

RSpec.describe Search do

  let(:search) { Search.new }

  describe '#initialize' do
    it 'should set the category if tab is present' do
      expect(Search.new(tab: 'nz').and).to_not be_nil
    end
  end
end
