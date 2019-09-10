# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Search do
  let(:search) { described_class.new }

  describe '#initialize' do
    it 'sets the category if tab is present' do
      expect(described_class.new(tab: 'nz').and).not_to be_nil
    end
  end
end
