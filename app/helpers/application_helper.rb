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

  def embedded_svg(filename, options = {})
    assets = Rails.application.assets
    file = assets.find_asset(filename).source.force_encoding('UTF-8')
    doc = Nokogiri::HTML::DocumentFragment.parse(file)
    svg = doc.at_css('svg')
    svg['class'] = options[:class] if options[:class].present?
    raw(doc)
  end
end
