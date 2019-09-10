require 'rails_helper'

RSpec.describe RecordsHelper do
  let(:record) { FactoryBot.build(:record) }

  describe '#source_contributor_name' do
    it 'displays the contributing content partner' do
      expect(helper.source_contributor_name(record)).to eq('<p>Culture, Europeana</p>')
    end
  end

  describe '#record_thumbnail' do
    before(:each) do
      @search = double(:search, :options => nil, :url_options => nil)
    end

    context 'the record has an image' do
      it 'should render a link with an image' do
        expect(helper.record_thumbnail(record, @search)).to eq(
          %{<div>#{link_to image_tag(record.image_url, :alt => "Title", :title => "Title"), "/records/#{record.id}"}</div>}
        )
      end
    end

    it 'should append the search options to the image link' do
      allow(@search).to receive(:options) { { text: 'fish'} }

      expect(helper.record_thumbnail(record, @search)).to match('search%5Btext%5D=fish')
    end

    it 'should generate a link with no query parameters when there are no search options' do
      allow(@search).to receive(:options) { {} }
      expect(helper.record_thumbnail(record, @search)).to match('<a href="\/records\/31938663">')
    end

    it 'should generate a link with search parameters when search options are passed' do
      allow(@search).to receive(:options) { {text: 'fish'} }
      expect(helper.record_thumbnail(record, @search)).to match('<a href="\/records\/31938663\?search%5Btext%5D=fish">')
    end

    context '#date_parser_for' do
      it "should return the same string if its not a date" do
        expect(helper.date_parser_for("not a date string")).to eq "not a date string"
      end

      it "should return date formated string" do
        expect(helper.date_parser_for("05-02-1986")).to eq "05 Feb 1986"
      end
    end

  end
end
