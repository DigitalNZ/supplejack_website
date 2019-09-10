require 'rails_helper'

RSpec.describe ApplicationHelper do

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
			expect(helper.site_title('Lorem')).to eq "Lorem"
		end
	end

	describe "#active_scope_filter" do
		before(:each) do
			allow(helper).to receive(:scope_params) { "nz" }
			@search = double(:search, params: { tab: "nz"})
		end

		it "sets active class to nil if the options don\'t match search params" do
			expect(helper.active_scope_filter("All", { tab: "all" })).to match "<li class=\"country-filter\">"
		end

		it "sets active class to active-scope if the options match tab params" do
			expect(helper.active_scope_filter("New Zealand", { tab: "nz" })).to match "<li class=\"country-filter active-scope\">"
		end
	end

  describe '#search_tab_options' do
    before {
      @search = Search.new(text: 'dog', page: 5)
    }

    it 'returns a hash' do
      expect(helper.search_tab_options(@search.options, 'images')).to be_a_kind_of(Hash)
    end

    it 'removes page' do
      expect(helper.search_tab_options(@search.options, 'images').values).not_to include(5)
    end

    it 'merges tab' do
      expect(helper.search_tab_options(@search.options, 'images').keys).to match_array([:text, :tab])
    end
  end

end
