# frozen_string_literal: true

module CountriesHelper
  def visit_badge(country)
    visit = current_user&.checkins&.find_by(country: country)
    return unless visit

    status = visit_badge_status_class(visit.in_past?)
    content = visit_badge_content(visit.in_past?)
    tag.span(content, class: ['badge', 'badge-sm', 'text-sm', status.to_s])
  end

  private

  def visit_badge_content(past_visit)
    past_visit ? 'visited' : 'upcoming'
  end

  def visit_badge_status_class(past_visit)
    past_visit ? 'badge-success' : 'badge-info'
  end
end
