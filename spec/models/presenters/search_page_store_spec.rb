require 'json'

module Presenters
  RSpec.describe SearchPageStore do
    let(:search) do
      search = Search.new(
        text: 'a users search',
        i: {
          usage: 'All Rights Reserved'
        },
        or: {
          collection: ['95bfm', 'TAPUHI']
        }
      )
      allow(search).to receive(:facets).and_return([OpenStruct.new(name: 'facet1', values: 'values')])

      search
    end
    let(:result) {JSON.parse(subject.call(search)).deep_symbolize_keys}

    describe ':searchValue' do
      it 'contains the users search' do
        expect(result[:searchValue]).to eq('a users search')
      end
    end

    describe ':panel' do
      it 'sets open to false' do
        expect(result[:panel][:open]).to eq(false)
      end

      it 'sets the tab to 0' do
        expect(result[:panel][:tab]).to eq(0)
      end

      it 'sets facets to a hash of the facets returned by the search' do
        expect(result[:panel][:facets]).to eq(facet1: 'values')
      end

      it 'sets facets to an empty array if there are no facets in the search' do
        allow(search).to receive(:facets).and_return(nil)

        expect(result[:panel][:facets]).to eq([])
      end
    end

    describe ':filters' do
      it 'handles i params' do
        expect(result[:filters]).to include(facet: 'usage', value: 'All Rights Reserved')
      end

      it 'handles or params' do
        expect(result[:filters]).to include(facet: 'collection', value: 'TAPUHI')
      end
    end
  end
end
