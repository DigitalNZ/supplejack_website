# frozen_string_literal: true

Dir[Rails.root + 'lib/supplejack/**/*.rb'].sort.each do |file|
  require file
end
