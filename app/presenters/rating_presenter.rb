class RatingPresenter < BasePresenter
  def rating_label
    h.content_tag(:span, class: 'rating label label-primary') do
      output = ActionView::OutputBuffer.new
      output << h.content_tag(:span, nil, class: 'glyphicon glyphicon-star', style: 'color: gold')
      output << h.content_tag(:span, 42, class: 'rating-value')
    end
  end
end