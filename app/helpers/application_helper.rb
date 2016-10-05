module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Countryfier'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def render_date(date)
    h(date.strftime('%Y-%m-%d')) if date
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
