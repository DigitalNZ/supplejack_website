# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

require 'spec_helper'

describe "user_sets/show.html.haml" do
  let(:set) {
    double(:set, {
      name: 'test set, this is a very long title so that I can test the title being truncated at 40 characters', 
      user: double(:user, name: 'test_user'), 
      tags: ['tag1', 'tag2'], 
      description: 'test description',
      items: [
        stub_model(Supplejack::Item, title: 'Record 1', thumbnail_url: 'http://lorempixel.com/250/250', record_id: 1),
        stub_model(Supplejack::Item, title: 'Record 2', thumbnail_url: 'http://lorempixel.com/150/150', record_id: 2)
      ]
    })
  }

  before do
    assign(:user_set, set)
    assign(:records, set.items)
    assign(:search, double(:search, options: nil))

    render
  end

  it 'sets the page title to the set name truncated to 40 characters' do
    title = set.name.truncate(40)

    expect(view.content_for(:title)).to match(/#{title}/)
  end

  it 'displays each record' do
    set.items.each do |item|
      expect(rendered).to match(/#{item.title}/)
    end
  end

  context "about" do
    it 'displays the name of the set' do
      expect(rendered).to match(/#{set.name}/)
    end

    it 'displays the creator of the set' do
      expect(rendered).to match(/#{set.user.name}/)
    end

    it 'displays the tags the set has' do
      set.tags.each do |tag|
        expect(rendered).to match(/#{tag}/)
      end
    end

    it 'displays the description of the set' do
      expect(rendered).to match(/#{set.description}/)
    end
  end
end
