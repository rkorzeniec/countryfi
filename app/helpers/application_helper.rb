module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Countryfier'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def render_date(date)
    h(date.strftime('%Y-%m-%d')) if date
  end
end
