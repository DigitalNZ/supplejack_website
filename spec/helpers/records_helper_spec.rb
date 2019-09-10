# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecordsHelper do
  let(:record) { FactoryBot.build(:record) }

  describe '#source_contributor_name' do
    it 'displays the contributing content partner' do
      expect(helper.source_contributor_name(record)).to eq('<p>Culture, Europeana</p>')
    end
  end

  describe '#record_thumbnail' do
    let(:search) { instance_double('Search', options: nil) }

    context 'when the record has an image' do
      it 'renders a link with an image' do
        expect(helper.record_thumbnail(record, search)).to eq(
          %(<div>#{link_to image_tag(record.image_url, alt: 'Title', title: 'Title'), "/records/#{record.id}"}</div>)
        )
      end
    end

    it 'appends the search options to the image link' do
      allow(search).to receive(:options).and_return(text: 'fish')

      expect(helper.record_thumbnail(record, search)).to match('search%5Btext%5D=fish')
    end

    it 'generates a link with no query parameters when there are no search options' do
      allow(search).to receive(:options).and_return({})
      expect(helper.record_thumbnail(record, search)).to match('<a href="\/records\/31938663">')
    end

    it 'generates a link with search parameters when search options are passed' do
      allow(search).to receive(:options).and_return(text: 'fish')
      expect(helper.record_thumbnail(record, search)).to match('<a href="\/records\/31938663\?search%5Btext%5D=fish">')
    end
  end

  describe '#date_parser_for' do
    it 'returns the same string if its not a date' do
      expect(helper.date_parser_for('not a date string')).to eq 'not a date string'
    end

    it 'returns date formated string' do
      expect(helper.date_parser_for('05-02-1986')).to eq '05 Feb 1986'
    end
  end
end
