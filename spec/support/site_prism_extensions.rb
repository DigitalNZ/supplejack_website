module SitePrismExtensions
  def simple_element(id)
    css_id = "##{id.to_s.tr('_', '-')}"

    send(:element, id, css_id)
  end
end

SitePrism::Section.send(:extend, SitePrismExtensions)
SitePrism::Page.send(:extend, SitePrismExtensions)
