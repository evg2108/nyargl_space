module PageTitleHelper
  def set_page_title(title)
    @_page_title = title
    nil
  end

  def get_page_title
    @_page_title
  end

  def page_title_exist?
    @_page_title.present?
  end
end