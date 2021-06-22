# frozen_string_literal: true

json.pagination paginate(@timeline)
json.next_page @timeline.next_page
json.items render(
  partial: 'timeline',
  locals: { timeline: @timeline },
  formats: [:html]
)
