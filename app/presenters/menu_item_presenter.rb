class MenuItemPresenter < BasePresenter
  def to_link
    classes = %w(list-group-item-responsive col-md-12 col-xs-3)
    classes << 'active' if active?
    h.link_to I18n.t("model.menu_item.#{object.slug}"), link, class: classes
  end

  def active?
    h.current_page?(object.page_identifier)
  end

  def link
    h.url_for(object.page_identifier.merge(anchor: CONTENT_SECTION))
  end
end