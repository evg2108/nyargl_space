class Draper::CollectionDecorator
  # delegate kaminari methods
  delegate :current_page, :total_pages, :limit_value
end