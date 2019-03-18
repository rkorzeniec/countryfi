module ApplicationHelper
  def page_title
    if @page_title.present?
      @page_title
    else
      'Countrify'
    end
  end

  def render_date(date)
    return unless date
    date.strftime('%Y-%m-%d')
  end

  def nav_item_id(path)
    path.split('/').join('-')[1..-1]
  end
end
