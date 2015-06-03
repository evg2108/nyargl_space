class PanelPresenter < BasePresenter
  def render
    h.content_tag(:div, class: %w(panel panel-default), id: @options[:id].presence) do
      panel_parts = ActionView::OutputBuffer.new
      if @options[:title].present?
        panel_parts << h.content_tag(:div, class: %w(panel-heading)) do
          h.content_tag(:strong, @options[:title])
        end
      end

      panel_parts << h.content_tag(:div, @content, class: %w(panel-body))
    end
  end
end