class Story < ActiveRecord::Base

	include ActionView::Helpers::TextHelper
	include ActionView::Helpers::UrlHelper
	include ActionView::Helpers::AssetTagHelper

	has_and_belongs_to_many :communities
	
	def to_s
		self.name
	end

	def to_param
		self.user_set.id
	end

	def user_set
		begin
			@set ||= Supplejack::UserSet.find(self.user_set_id)
		rescue
			@set = Supplejack::UserSet.new
		end
	end

	def name 
		self.user_set.name || 'New Story'
	end

	def description 
		self.user_set.description
	end

	def content_output
		if self.content.blank?
			output = simple_format(self.description.to_s).html_safe

			self.items.each do |item|
				output += image_tag(item.thumbnail_url)
			end

			if self.user_set.id.nil?
				output = "Tell us a bit about your story here. Use the palette on the left to add content and style your documents."
			end

			output
		else
			o = JSON.parse self.content
			o['main'].html_safe
		end
	end

	def feature_image
		begin
			self.items.first.large_thumbnail_url
		rescue
			'temp-image.jpg'
		end
	end

	def items 
		self.user_set.items
	end

	def top_keywords
	    # https://github.com/domnikl/highscore
	    word_score = Highscore::Content.new ([self.user_set.name, self.user_set.description] + self.user_set.items.collect{|r| r.title}).join(' ')
	    word_score.configure do
	      set :ignore_case, true
	    end
	    word_score.keywords.top(3)
	end

	def suggested_images(count = 6)
		# TODO : Filter out items already in set
		search_string = self.top_keywords.collect{|k| k.text.downcase }.join(' OR ')
	    count = count.to_i
	    count = 6 if count < 1
	    suggestions = Search.new(text: search_string, per_page: count)
	    SearchTab.add_category_facets(suggestions, 'Images')
	    suggestions.results
	end

end
