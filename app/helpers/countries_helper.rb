# frozen_string_literal: true

module CountriesHelper
  def visit_badge(country)
    return unless current_user&.countries&.include?(country)

    visited_country = current_user.visited_countries.include?(country)
    badge_status = visited_country ? 'badge-success' : 'badge-info'
    badge_content = visited_country ? 'visited' : 'upcoming'

    tag.span(badge_content, class: ['badge', 'badge-sm', 'text-sm', badge_status])
  end
end
