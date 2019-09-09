# The majority of The Supplejack Website code is Crown copyright (C) 2014,
# New Zealand Government, and is licensed under the GNU General Public License,
# version 3. Some components are third party components that are licensed under
# the MIT license or other terms.
# See https://github.com/DigitalNZ/supplejack_website for details.
#
# Supplejack was created by DigitalNZ at the National Library of NZ and
# the Department of Internal Affairs.
# http://digitalnz.org/supplejack

# Search
class Search < Supplejack::Search
  def initialize(params = {})
    params = params.dup
    params[:i] ||= {}
    params[:or] ||= {}
    self.and ||= {}
    self.or ||= {}

    super(params)

    params = params.to_unsafe_hash if params.is_a? ActionController::Parameters
    self.or.merge!(params[:or])
  end
end
