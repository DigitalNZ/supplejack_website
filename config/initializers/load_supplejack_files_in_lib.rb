# frozen_string_literal: true

Dir[Rails.root + 'lib/supplejack/**/*.rb'].each do |file|
  require file
end
