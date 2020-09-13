# frozen_string_literal: true

module CountriesHelper
  def visit_badge(country)
    visit = current_user&.checkins&.find_by(country: country)
    return unless visit

    status, content = visit.in_past? ? %w[success visited] : %w[info upcoming]
    tag.span(content, class: ['badge', 'badge-sm', 'text-sm', "badge-#{status}"])
  end
end
