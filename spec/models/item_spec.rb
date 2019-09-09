require 'rails_helper'

RSpec.describe Supplejack::Item do

  describe "#image_url" do
    let(:item) {
      Supplejack::Item.new({
        thumbnail_url: 'http://test.com/img.png'
      })
    }

    it 'returns a url to serve a resized image' do
      expect(item.image_url).to eq("#{THUMBNAIL_SERVER_URL}?resize=204&src=http%3A%2F%2Ftest.com%2Fimg.png")
    end

    it 'returns a url to serve the original size if passed :original as an option' do
      expect(item.image_url({original: true})).to eq("#{THUMBNAIL_SERVER_URL}?src=http%3A%2F%2Ftest.com%2Fimg.png")
    end

    it 'returns a url to serve a custom sized image if passed the width option' do
      expect(item.image_url({width: 500})).to eq("#{THUMBNAIL_SERVER_URL}?resize=500&src=http%3A%2F%2Ftest.com%2Fimg.png")
    end

    it 'handles nil thumbnail_urls' do
      expect(Supplejack::Item.new.image_url).to eq("#{THUMBNAIL_SERVER_URL}?resize=204&src=")
    end
  end
end
