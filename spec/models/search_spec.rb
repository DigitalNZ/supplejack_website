# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

require 'spec_helper'

describe Search do

  let(:search) { Search.new }

  describe '#initialize' do
    it 'should set the category if tab is present' do
      @search = Search.new(tab: 'nz')
      @search.and.should_not be_nil
    end
  end
end