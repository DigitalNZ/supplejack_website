# The majority of The Supplejack Website code is Crown copyright (C) 2014,
# New Zealand Government, and is licensed under the GNU General Public License,
# version 3. Some components are third party components that are licensed under
# the MIT license or other terms.
# See https://github.com/DigitalNZ/supplejack_website for details.
#
# Supplejack was created by DigitalNZ at the National Library of NZ and
# the Department of Internal Affairs.
# http://digitalnz.org/supplejack

# Application Helper
module ApplicationHelper
  def title(*args)
    args.delete_if { |e| e.blank? }
    args = args.map { |e| truncate(e, length: 40) }
    title = (args + [t('site_title')]).join(' | ')
    content_for(:title) { title }
  end

  def site_title(yield_title = nil)
    yield_title.presence || t('site_title')
  end

  def active_scope_filter(title, options = {})
    active_class = 'country-filter'
    scope_options = options[:tab].present? ? options[:tab] : 'all'
    scope_params = @search.params[:tab].present? ? @search.params[:tab] : 'all'

    active_class += ' active-scope' if scope_options == scope_params

    content_tag(:li, class: active_class) do
      link_to title, records_path(options)
    end
  end

  def search_tab_options(options, tab)
    options.delete(:page)
    tab.eql?('All') ? options : options.merge(tab: tab)
  end
end
