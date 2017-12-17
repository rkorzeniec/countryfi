module CountriesHelper
  def country_code_array(countries)
    countries.map(&:cca2)
  end

  def visit_label(user, country)
    return unless user.countries.include?(country)
    label_status = visit_label_status(user, country)
    label_content = visit_label_content(user, country)
    content_tag(:span, label_content, class: ['label', label_status])
  end

  private

  def visit_label_status(user, country)
    user.visited_countries.include?(country) ? 'label-success' : 'label-info'
  end

  def visit_label_content(user, country)
    user.visited_countries.include?(country) ? 'visited' : 'upcoming'
  end
end
