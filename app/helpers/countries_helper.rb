# frozen_string_literal: true

module CountriesHelper
  def visit_label(country)
    return unless current_user&.countries&.include?(country)

    visited_country = current_user.visited_countries.include?(country)
    label_status = visited_country ? 'label-success' : 'label-info'
    label_content = visited_country ? 'visited' : 'upcoming'

    tag.span(label_content, class: ['label', label_status])
  end
end
