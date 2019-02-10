module CountriesHelper
  def visit_label(user, country)
    return unless user&.countries.include?(country)

    visited_country = user.visited_countries.include?(country)
    label_status = visited_country ? 'label-success' : 'label-info'
    label_content = visited_country ? 'visited' : 'upcoming'

    content_tag(:span, label_content, class: ['label', label_status])
  end
end
