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

      it "sets panelButtonText to 'Close'" do
        expect(result[:panel][:buttonText]).to eq('Close')
      end

      it 'sets filtersToApply to false' do
        expect(result[:panel][:filtersToApply]).to eq(false)
      end

      it 'sets facets to a hash of the facets returned by the search' do
        expect(result[:panel][:facets]).to eq(facet1: 'values')
      end

      it 'sets facets to an empty array if there are no facets in the search' do
        allow(search).to receive(:facets).and_return(nil)

        expect(result[:panel][:facets]).to eq([])
      end

      context 'special cases' do
        it 'limits the decade facet to values between 1000 and current year' do
          allow(search).to receive(:facets).and_return([
            OpenStruct.new(name: 'decade', values: {
              '900' => 1, '1000' => 1, '1990' =>1, '3000' => 1
              })
            ])

          expect(result[:panel][:facets]).to eq(decade: {:'1000' => 1, :'1990' => 1})
        end
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
