class MenuItemPresenter < BasePresenter
  def to_link
    classes = %w(list-group-item-responsive col-md-12 col-xs-3)
    classes << 'active' if active?
    h.link_to I18n.t("model.menu_item.#{object.slug}"), link, class: classes
  end

  def active?
    h.controller_name.to_s == object.controller_name.to_s && h.action_name.to_s == object.action_name.to_s
  end

  def link
    h.url_for(controller: object.controller_name, action: object.action_name)
  end
end