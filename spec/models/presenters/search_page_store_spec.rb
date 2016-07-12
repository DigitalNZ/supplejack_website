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

    let(:category_stats) do 
      {All: 10000, Images: 99999}
    end

    let(:result) {JSON.parse(subject.call(search, category_stats)).deep_symbolize_keys}

    describe ':searchValue' do
      it 'contains the users search' do
        expect(result[:searchValue]).to eq('a users search')
      end
    end

    describe ':searchCategory' do
      it 'contains the active category that the user is searching with' do
        expect(result[:searchTabs][:activeTab]).to eq('All')
      end

      it "contains the statistics of results in each category" do
        expect(result[:searchTabs][:categoryStats]).to include({:category=>"All", :count=>"10,000"})
        expect(result[:searchTabs][:categoryStats]).to include({:category=>"Images", :count=>"99,999"})
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

    describe ':category_count_formatting' do
      it 'handles empty hash' do
        search_results = SearchPageStore.new.send(:category_count_formatting, {})
        expect(search_results).to eq([])
      end

      it 'handles a hash like' do
        search_results = SearchPageStore.new.send(:category_count_formatting, {"All"=>2413461, "Images"=>1483736, "Audio"=>6549, "Videos"=>16438})
        expect(search_results).to include({:category=>"All", :count=>"2,413,461"})
      end
    end
  end
end
