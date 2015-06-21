class RatingPresenter < BasePresenter
  def rating_label
    h.content_tag(:span, class: 'rating') do
      h.content_tag(:span, class: 'label label-primary') do
        output = ActionView::OutputBuffer.new
        output << h.content_tag(:span, nil, class: 'glyphicon glyphicon-star', style: 'color: gold')
        output << h.content_tag(:span, 42)
      end
    end
  end
end