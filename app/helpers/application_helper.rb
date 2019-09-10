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

  def search_tab_options(options, tab)
    options.delete(:page)
    tab.eql?('All') ? options : options.merge(tab: tab)
  end
end
