class MenuItemPresenter < BasePresenter
  def to_link(options = {})
    options[:class] ||= []
    options[:class] << ' active' if active?
    h.link_to I18n.t("model.menu_item.#{object.controller_name.to_s.sub('/', '.')}"), link, options
  end

  def to_tab
    h.content_tag :li, role: 'presentation', class: ('active' if active?) do
      h.link_to I18n.t("model.menu_item.#{object.controller_name.to_s.sub('/', '.')}"), link
    end
  end

  def active?
    object.active_for_any_actions ? h.controller_path == object.controller_name.to_s : h.current_page?(object.page_identifier)
  end

  def link
    h.url_for(object.page_identifier.merge(anchor: Anchors::CONTENT_SECTION))
  end
end