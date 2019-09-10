require 'rails_helper'

RSpec.describe Record do

  describe '#image_url' do
    it 'should tell the thumbailer the specified width' do
      record = Record.new(thumbnail_url: 'https://picasa.com/image.png')
      expect(record.image_url(width: 300)).to eq("#{THUMBNAIL_SERVER_URL}?resize=300&src=https%3A%2F%2Fpicasa.com%2Fimage.png")
    end

    it 'should resize the thumbnail_url through the thumbnailer' do
      record = Record.new(thumbnail_url: 'http://picasa.com/small_image.png')
      expect(record.image_url).to eq("#{THUMBNAIL_SERVER_URL}?resize=204&src=http%3A%2F%2Fpicasa.com%2Fsmall_image.png")
    end

    it 'should use thumbnail_url if thumbnail_url is not present' do
      record = Record.new(thumbnail_url: 'http://picasa.com/regular_image.png')
      expect(record.image_url).to eq("#{THUMBNAIL_SERVER_URL}?resize=204&src=http%3A%2F%2Fpicasa.com%2Fregular_image.png")
    end

    it 'should tell the thumbnailer to get the original size' do
      record = Record.new(thumbnail_url: 'https://picasa.com/image.png')
      expect(record.image_url(original: true)).to eq("#{THUMBNAIL_SERVER_URL}?src=https%3A%2F%2Fpicasa.com%2Fimage.png")
    end
  end
end
