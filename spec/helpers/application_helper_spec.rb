# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

require 'spec_helper'

describe ApplicationHelper do

	describe '#title' do
		it 'should return site name if no arguments are passed' do
      helper.title
      expect(view.content_for(:title)).to eq(t('site_title'))
    end

    it 'truncates arguments that contains more than 40 characters' do
      arg = 'a' * 45
      helper.title(arg)
      expect(view.content_for(:title)).to match(/^#{truncate(arg, length: 40)}/)
    end

    it 'deletes blank arguments' do
      helper.title("arg1", "arg2", "")
      expect(view.content_for(:title)).to eq("arg1 | arg2 | #{t("site_title")}")
    end

    it 'joins the arguments and the site name with a pipe (|)' do
      helper.title('arg1', 'arg2', 'arg3')
      expect(view.content_for(:title)).to eq("arg1 | arg2 | arg3 | #{t("site_title")}") 
    end
	end

	describe '#site_title' do
		it 'should return site title if no parameters' do
			expect(helper.site_title).to eq t('site_title')
		end

		it "should return site title and yield title if present" do
			helper.site_title('Lorem').should eq "Lorem"
		end
	end

	describe "#active_scope_filter" do
		before(:each) do
			helper.stub(:scope_params) { "nz" }
			@search = double(:search, params: { tab: "nz"})
		end

		it "sets active class to nil if the options don\'t match search params" do
			helper.active_scope_filter("All", { tab: "all" }).should match "<li class=\"country-filter\">"
		end

		it "sets active class to active-scope if the options match tab params" do
			helper.active_scope_filter("New Zealand", { tab: "nz" }).should match "<li class=\"country-filter active-scope\">"
		end
	end

  describe '#search_tab_options' do
    before {
      @search = Search.new(text: 'dog', page: 5)
    }

    it 'returns a hash' do
      helper.search_tab_options(@search.options, 'images').should be_a_kind_of(Hash) 
    end

    it 'removes page' do
      helper.search_tab_options(@search.options, 'images').values.should_not include(5)  
    end

    it 'merges tab' do
      helper.search_tab_options(@search.options, 'images').keys.should =~ [:text, :tab]
    end
  end
  
end