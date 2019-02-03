module ApplicationHelper
  def page_title
    if @page_title.present?
      @page_title
    else
      'Countryfier'
    end
  end

  def render_date(date)
    return unless date
    date.strftime('%Y-%m-%d')
  end
end
