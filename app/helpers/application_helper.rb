module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Countryfier'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
