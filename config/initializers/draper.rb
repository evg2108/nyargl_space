class Draper::CollectionDecorator
  # delegate will_paginate methods
  delegate :current_page, :per_page, :offset, :total_entries, :total_pages
end