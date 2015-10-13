class ContributedItem < ActiveRecord::Base

	mount_uploader :item_path, ContributedImageUploader

	belongs_to :user
	has_and_belongs_to_many :communities

	def to_s
		self.name
	end

end
