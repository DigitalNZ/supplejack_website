class Community < ActiveRecord::Base

	has_and_belongs_to_many :stories
	has_and_belongs_to_many :contributed_items


	def to_param
		self.slug
	end

	def to_s
		self.name
	end

	def feature_image
		if self.feature_image_url.blank?
			'temp-image.jpg'
		else
			self.feature_image_url
		end
	end

end
