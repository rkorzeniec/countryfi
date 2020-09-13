# frozen_string_literal: true

module CountriesHelper
  def visit_badge(country)
    visit = current_user&.checkins&.find_by(country: country)
    return unless visit

    status, content = visit.in_past? ? %w[badge-success visited] : %w[badge-info upcoming]
    tag.span(content, class: ['badge', 'badge-sm', 'text-sm', status])
  end
end
