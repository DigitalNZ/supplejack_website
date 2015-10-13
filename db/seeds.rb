# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

require 'csv'

Community.delete_all
Story.delete_all



CSV.foreach("db/seeds/kete.csv", headers: true) do |kete|

	puts kete['Slug']

	c = Community.create(
		name: kete['Slug'],
		description: kete['Description'],
		slug: kete['Slug'].parameterize,
		kete_slug: kete['Existing Kete'],
		feature_image_url: kete['Image ']
	)

	kete['Sets'].scan(/user_sets\/([0-9a-f]+)/).each do |set|
		puts set
		s = Story.find_or_create_by(user_set_id: set.first)
		s.communities << c
		s.save
	end

end

