module PageTitleHelper
  extend ActiveSupport::Concern

  included do
    helper_method :set_page_title, :get_page_title, :page_title_exist?
  end

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