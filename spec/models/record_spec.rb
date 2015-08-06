# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

# encoding: UTF-8
require 'spec_helper'

describe Record do
  before(:each) do
    @record = ::Record.new
    @mock_subject = double(:date_subject).as_null_object
  end

  describe '#image_url' do
    before(:each) do
      @record.stub(:thumbnail_url) { 'https://picasa.com/image.png' }
      @record.stub(:display_collection) { nil }
      @record.stub(:landing_url) { nil }
    end

    it 'should tell the thumbailer the specified width' do
      @record.image_url(:width => 300).should eq "#{THUMBNAIL_SERVER_URL}?resize=300&src=https%3A%2F%2Fpicasa.com%2Fimage.png"
    end

    it 'should resize the thumbnail_url through the thumbnailer' do
      @record.stub(:thumbnail_url) { 'http://picasa.com/small_image.png' }
      @record.image_url.should eq "#{THUMBNAIL_SERVER_URL}?resize=204&src=http%3A%2F%2Fpicasa.com%2Fsmall_image.png"
    end

    it 'should use thumbnail_url if thumbnail_url is not present' do
      @record.stub(:thumbnail_url) { nil }
      @record.stub(:thumbnail_url) { 'http://picasa.com/regular_image.png' }
      @record.image_url.should eq "#{THUMBNAIL_SERVER_URL}?resize=204&src=http%3A%2F%2Fpicasa.com%2Fregular_image.png"
    end

    it 'should tell the thumbnailer to get the original size' do
      @record.stub(:thumbnail_url) { 'https://picasa.com/image.png' }
      @record.image_url(original: true).should eq "#{THUMBNAIL_SERVER_URL}?src=https%3A%2F%2Fpicasa.com%2Fimage.png"
    end
  end
end
